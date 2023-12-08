class AddTimelimitToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :timelimit, :date, default: -> { 'CURRENT_DATE' }, null: false
  end
end
