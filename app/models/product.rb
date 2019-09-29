class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than: 0 }
end
