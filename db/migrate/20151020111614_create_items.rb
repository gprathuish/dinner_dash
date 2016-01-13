class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 7, scale: 2

      t.timestamps null: false
    end
  end
end
