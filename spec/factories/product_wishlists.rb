FactoryBot.define do
  factory :product_wishlist do
    product
    wishlist
    bought { false }
  end
end
