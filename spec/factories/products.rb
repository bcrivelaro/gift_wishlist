FactoryBot.define do
  factory :product do
    category
    sequence(:name) { |n| "Product #{n}" }
    description { 'description' }
    price { 9.99 }
  end
end
