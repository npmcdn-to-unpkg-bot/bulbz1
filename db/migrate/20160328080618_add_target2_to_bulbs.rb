class AddTarget2ToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :target2, :string
  end
end
