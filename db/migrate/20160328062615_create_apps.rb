class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :title
      t.string :target
      t.text :description
      t.string :picture

      t.timestamps null: false
    end
  end
end
