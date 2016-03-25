class AddPictureToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :picture, :string
  end
end
