require_relative "../../lib/board"

class CreateBoardsTable < ActiveRecord::Migration[5.2]
  def up
    create_table :boards do |col|
      col.string :title
    end

    Board.create(title: "Default")
  end

  def down
    remove_table :boards
  end
end
