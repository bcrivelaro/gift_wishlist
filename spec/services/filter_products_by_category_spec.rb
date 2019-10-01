RSpec.describe FilterProductsByCategory do
  let!(:cat1) { create :category }
  let!(:cat2) { create :category, parent: cat1 }
  let!(:cat3) { create :category, parent: cat2 }
  let!(:cat4) { create :category }
  let!(:prod1) { create :product, category: cat1 }
  let!(:prod2) { create :product, category: cat2 }
  let!(:prod3) { create :product, category: cat3 }
  let!(:prod4) { create :product, category: cat4 }

  describe '.call' do
    context 'Product collection' do
      it 'returns products of category and it descendants' do
        service = FilterProductsByCategory.call(cat2, Product.all)

        expect(service).to match_array([prod2, prod3])
      end
    end

    context 'ProductWishlist collection' do
      it 'returns products of category and it descendants' do
        wishlist = create :wishlist
        create :product_wishlist, wishlist: wishlist, product: prod1
        pw2 = create :product_wishlist, wishlist: wishlist, product: prod2
        pw3 = create :product_wishlist, wishlist: wishlist, product: prod3
        create :product_wishlist, wishlist: wishlist, product: prod4
        collection = wishlist.product_wishlists.includes(:product)

        service = FilterProductsByCategory.call(cat2, collection)

        expect(service).to match_array([pw2, pw3])
      end
    end
  end
end
