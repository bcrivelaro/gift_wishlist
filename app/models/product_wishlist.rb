class ProductWishlist < ApplicationRecord
  belongs_to :product
  belongs_to :wishlist

  def can_be_destroyed?
    !bought?
  end
end
