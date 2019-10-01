class ShoppingCart < ApplicationRecord
  has_and_belongs_to_many :product_wishlists

  def can_checkout?
    product_wishlists.any?
  end
end
