class RemoveTokenFromWishlists < ActiveRecord::Migration[5.2]
  def change
    remove_column :wishlists, :token
  end
end
