class AddDescriptionToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :description, :text
  end
end
