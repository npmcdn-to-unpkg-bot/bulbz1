class AddStuffToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :type, :string
    add_column :bulbs, :target, :string
  end
end
