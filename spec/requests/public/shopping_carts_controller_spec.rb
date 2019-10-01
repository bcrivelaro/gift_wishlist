RSpec.describe Public::ShoppingCartsController, type: :request do
  let(:wishlist) { create :wishlist }
  let(:p1) { create :product, price: 10.00 }
  let(:p2) { create :product, price: 20.00 }
  let(:pw1) { create :product_wishlist, wishlist: wishlist, product: p1 }
  let(:pw2) { create :product_wishlist, wishlist: wishlist, product: p2 }

  describe 'GET #show' do
    before do
      get public_shopping_cart_path # create shopping cart
      shopping_cart = ShoppingCart.last
      shopping_cart.product_wishlists << pw1
      shopping_cart.product_wishlists << pw2
      shopping_cart.save!
      get public_shopping_cart_path
    end

    it { expect(response).to be_successful }
    it do
      expect(
        assigns(:product_wishlists).all? { |t| t.is_a? ProductWishlist }
      ).to eq(true)
    end
    it { expect(assigns(:product_wishlists).count).to eq(2) }
    it { expect(assigns(:total)).to eq(30) }
  end

  describe 'POST #add_product' do
    context 'success scenario' do
      before do
        get public_shopping_cart_path # create shopping cart
        post add_product_public_shopping_cart_path(product_wishlist_id: pw1.id)
      end

      it { expect(ShoppingCart.last.product_wishlists.count).to eq(1) }
      it do
        expect(response).to(
          redirect_to(public_wishlist_products_path(pw1.wishlist))
        )
      end
      it { expect(flash[:notice]).to be_present }
    end

    context 'failure scenario' do
      before do
        get public_shopping_cart_path # create shopping cart
        post add_product_public_shopping_cart_path(product_wishlist_id: 999)
      end

      it { expect(ShoppingCart.last.product_wishlists.count).to eq(0) }
      it { expect(response).to redirect_to(public_wishlists_path) }
      it { expect(flash[:error]).to be_present }
    end
  end

  describe 'POST #checkout' do
    context 'success scenario' do
      before do
        get public_shopping_cart_path # create shopping cart
        shopping_cart = ShoppingCart.last
        shopping_cart.product_wishlists << pw1
        shopping_cart.product_wishlists << pw2
        shopping_cart.save!
        post checkout_public_shopping_cart_path
      end

      it { expect(pw1.reload.bought).to eq(true) }
      it { expect(pw2.reload.bought).to eq(true) }
      it { expect(ShoppingCart.all.count).to eq(0) }
      it { expect(response).to redirect_to(public_wishlists_path) }
      it { expect(flash[:notice]).to be_present }
    end

    context 'failure scenario' do
      before do
        get public_shopping_cart_path # create shopping cart
        post checkout_public_shopping_cart_path
      end

      it { expect(ShoppingCart.all.count).to eq(1) }
      it { expect(response).to redirect_to(public_wishlists_path) }
      it { expect(flash[:error]).to be_present }
    end
  end
end
