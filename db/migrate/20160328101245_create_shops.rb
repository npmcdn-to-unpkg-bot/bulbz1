class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :title
      t.string :target
      t.text :description
      t.string :picture
      t.integer :bulb_id

      t.timestamps null: false
    end
  end
end
