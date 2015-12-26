class TasksController < ApplicationController
  before_filter :set_task, only: [:edit, :update]

  def index
    @date = -> {
      begin
        return Time.parse(params[:date])
      rescue
        return Time.now
      end
    }[]
    from = @date.beginning_of_month
    to = @date.end_of_month
    @tasks = Task.includes(:company).where(start_date: from..to).order(:start_date)
    @sum_time = @tasks.reduce(0){|arr,task| arr + (task.end_date - task.start_date) / 3600}
    @one_month_ago = @date - 1.month
    @one_month_from_now = @date + 1.month
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(tasks_params)
    respond_to do |format|
      if @task.save
        flash[:notice] = "タスク#{@task.id}を作成しました。"
        format.html { redirect_to action: :index }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(tasks_params)
        flash[:notice] = "タスク#{@task.id}を更新しました。"
        format.html { redirect_to action: :index }
      else
        format.html { render :edit }
      end
    end
  end

  def tasks_params
    params.require(:task).permit(
      :company_id, :start_date, :end_date, :description
    )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
