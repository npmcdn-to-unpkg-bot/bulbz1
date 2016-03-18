class CreateBulbs < ActiveRecord::Migration
  def change
    create_table :bulbs do |t|
      t.integer :user_id
      t.string :title
      t.text :what
      t.text :forwhom
      t.text :why
      t.text :need
      t.string :category
      t.boolean :private, :default => true

      t.timestamps
    end
  end
end
