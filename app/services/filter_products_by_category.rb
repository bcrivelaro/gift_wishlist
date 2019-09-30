class FilterProductsByCategory
  def initialize(category)
    @category = category
  end

  def self.call(category)
    new(category).call
  end

  def call
    return Product.all unless category

    Product.where(category: category.self_and_descendents_ids)
  end

  private

  attr_reader :category
end
