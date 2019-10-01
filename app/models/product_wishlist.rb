class ProductWishlist < ApplicationRecord
  belongs_to :product
  belongs_to :wishlist
  has_and_belongs_to_many :shopping_carts

  def can_be_destroyed?
    !bought?
  end
end
