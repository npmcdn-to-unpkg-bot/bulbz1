class AddArtToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :art, :string
  end
end
