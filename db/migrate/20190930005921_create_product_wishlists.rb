class CreateProductWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :product_wishlists do |t|
      t.references :product, foreign_key: true
      t.references :wishlist, foreign_key: true
      t.boolean :bought, null: false

      t.timestamps
    end
  end
end
