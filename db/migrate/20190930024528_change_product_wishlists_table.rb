class ChangeProductWishlistsTable < ActiveRecord::Migration[5.2]
  def change
    change_column :product_wishlists, :bought, :boolean, null: false, default: false
  end
end
