class CreateJoinTableProductWishlistsShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :product_wishlists, :shopping_carts do |t|
      t.index %i[product_wishlist_id shopping_cart_id], name: 'pw_sc_index'
      # t.index [:shopping_cart_id, :product_wishlist_id]
    end
  end
end
