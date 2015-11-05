class Work::TasksController < ApplicationController
  def index
    @tasks = Task.all.order(:start_date)
    @csv = @tasks.map{|t| "#{t.start_date.day},#{t.start_date.strftime('%H:%M:%S')},#{t.end_date.strftime('%H:%M:%S')},,#{(t.end_date - t.start_date) / (60 * 60)}"}.join("<br />").html_safe
  end

  def show
  end

  def new
    @task = [:work, Task.new]
  end

  def create
    task = Task.new(task_params)
    respond_to do |format|
      if task.save
        flash[:notice] = t('.success')
        format.html { redirect_to action: :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @task = [:work, Task.find(params[:id])]
  end

  def destroy
  end

  def update
    task = Task.find(params[:id])
    respond_to do |format|
      if task.update(task_params)
        flash[:notice] = t('.success')
        format.html { redirect_to action: :index }
      else
        format.html { render :new }
      end
    end
  end

  private
  def task_params
    params.require(:task).permit(:company_id, :start_date, :end_date, :description)
  end
end
