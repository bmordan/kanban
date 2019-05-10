class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |col|
      col.string :name
      col.string :avatar
    end
  end
end
