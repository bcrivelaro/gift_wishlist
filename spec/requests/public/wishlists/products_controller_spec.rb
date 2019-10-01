RSpec.describe Public::Wishlists::ProductsController, type: :request do
  let(:wishlist) { create :wishlist }

  describe 'GET #index' do
    before do
      create_list :product_wishlist, 5, wishlist: wishlist
      get public_wishlist_products_path(wishlist)
    end

    it { expect(response).to be_successful }
    it do
      expect(
        assigns(:product_wishlists).all? { |t| t.is_a? ProductWishlist }
      ).to eq(true)
    end
    it do
      expect(
        assigns(:product_wishlists).map(&:wishlist).uniq
      ).to eq([wishlist])
    end
    it { expect(assigns(:product_wishlists).count).to eq(5) }
  end
end