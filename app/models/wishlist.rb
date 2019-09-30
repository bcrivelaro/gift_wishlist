class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :product_wishlists, dependent: :destroy
  has_many :products, through: :product_wishlists

  validates :name, presence: true
end
