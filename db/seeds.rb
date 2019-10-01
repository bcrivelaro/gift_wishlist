require 'factory_bot_rails'

top_level_categories = FactoryBot.create_list(:category, 10)
second_level_categories =
  top_level_categories.map do |tlc|
    FactoryBot.create(:category, parent: tlc)
  end
third_level_categories =
  second_level_categories.map do |slc|
    FactoryBot.create(:category, parent: slc)
  end

top_level_categories.each do |tlc|
  FactoryBot.create(:product, category: tlc, price: rand(1.00..1000.00))
end
second_level_categories.each do |slc|
  FactoryBot.create(:product, category: slc, price: rand(1.00..1000.00))
end
third_level_categories.each do |tlc|
  FactoryBot.create(:product, category: tlc, price: rand(1.00..1000.00))
end
