class ShoppingCart < ApplicationRecord
  has_and_belongs_to_many :product_wishlists
end
