class CreateBoardsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :boards do |col|
      col.string :title
    end
  end

  def down
    remove_table :boards
  end
end
