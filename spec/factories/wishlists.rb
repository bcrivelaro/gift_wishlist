FactoryBot.define do
  factory :wishlist do
    user
    name { 'name' }
    token { '123456' }
  end
end
