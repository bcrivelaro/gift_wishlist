RSpec.describe Public::WishlistsController, type: :request do
  describe 'GET #index' do
    before do
      create_list :wishlist, 2
      get public_wishlists_path
    end

    it { expect(response).to be_successful }
    it { expect(assigns(:wishlists).all? { |t| t.is_a? Wishlist }).to eq(true) }
    it { expect(assigns(:wishlists).count).to eq(2) }
  end
end