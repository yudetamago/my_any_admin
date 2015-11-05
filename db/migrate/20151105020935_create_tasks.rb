class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :company_id, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
