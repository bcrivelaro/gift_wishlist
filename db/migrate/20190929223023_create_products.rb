class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :products, :name, unique: true
  end
end
