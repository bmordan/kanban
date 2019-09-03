class CreateTasksTable < ActiveRecord::Migration[5.2]
  def up
    create_table :tasks do |col|
      col.string :task
      col.string :status
      col.string :colname
      col.integer :board_id
      col.integer :user_id
    end
  end

  def down
    remove_table :tasks
  end
end
