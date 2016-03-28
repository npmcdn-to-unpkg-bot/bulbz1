class AddReferenceToBulbs < ActiveRecord::Migration
  def change
    add_column :bulbs, :cat, :string
    add_column :bulbs, :ref_id, :integer
    add_column :bulbs, :target1, :string
  end
end
