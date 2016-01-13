class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :order, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
      t.integer :unit
      t.decimal :price, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
