class Product < ApplicationRecord
  belongs_to :category
  has_many :product_wishlists, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
end
