class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :title
      t.string :target
      t.text :description
      t.string :picture
      t.integer :bulb_id

      t.timestamps null: false
    end
  end
end
