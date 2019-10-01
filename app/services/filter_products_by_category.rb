class FilterProductsByCategory
  def initialize(category, collection)
    @category = category
    @collection = collection
  end

  def self.call(category, collection)
    new(category, collection).call
  end

  def call
    return collection unless category

    query =
      if klass == Product
        { category: category.self_and_descendents_ids }
      else
        { products: { category: category.self_and_descendents_ids } }
      end

    collection.where(query)
  end

  private

  attr_reader :category, :collection

  def klass
    collection.first.class
  end
end
