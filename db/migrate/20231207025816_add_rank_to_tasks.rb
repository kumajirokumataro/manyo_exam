class AddRankToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :rank, :integer, default: 0, null: false
  end
end
