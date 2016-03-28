class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :title
      t.string :target1
      t.string :target2
      t.text :description
      t.text :gain1
      t.text :gain2
      t.string :picture

      t.timestamps null: false
    end
  end
end
