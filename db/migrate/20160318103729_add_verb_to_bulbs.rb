class AddVerbToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :verb, :string
  end
end
