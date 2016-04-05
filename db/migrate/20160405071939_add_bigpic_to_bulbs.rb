class AddBigpicToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :big_picture, :string
  end
end
