RSpec.describe Wishlists::ProductsController, type: :request do
  context 'authenticated' do
    let(:user) { create :user }
    let(:wishlist) { create :wishlist, user: user }

    before { sign_in user }

    describe 'GET #index' do
      before do
        create_list :product_wishlist, 5, wishlist: wishlist
        get wishlist_products_path(wishlist)
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

    describe 'GET #new' do
      before { get new_wishlist_product_path(wishlist)	}

      it { expect(response).to be_successful }
      it { expect(assigns(:products).all? { |t| t.is_a? Product }).to eq(true) }
      it { expect(assigns(:products)).to match_array(Product.all) }
    end

    describe 'POST #create' do
      context 'success scenario' do
        let(:product) { create :product }

        before { post wishlist_products_path(wishlist, product_id: product.id)	}

        it { expect(response).to redirect_to wishlist_products_path(wishlist) }
        it { expect(wishlist.reload.products).to include(product) }
        it { expect(flash[:notice]).to be_present }
      end

      context 'failure scenario' do
        before { post wishlist_products_path(wishlist, product_id: nil)	}

        it { expect(response).to redirect_to wishlist_products_path(wishlist) }
        it { expect(flash[:error]).to be_present }
      end
    end

    describe 'DELETE #destroy' do
      context 'can be destroyed' do
        let!(:product_wishlist) do
          create :product_wishlist, wishlist: wishlist, bought: false
        end

        before { delete wishlist_product_path(wishlist, id: product_wishlist.id) }

        it { expect(response).to redirect_to wishlist_products_path(wishlist) }
        it { expect(wishlist.product_wishlists.count).to eq(0) }
        it { expect(flash[:notice]).to be_present }
      end

      context 'cannot be destroyed' do
        let!(:product_wishlist) do
          create :product_wishlist, wishlist: wishlist, bought: true
        end

        before { delete wishlist_product_path(wishlist, id: product_wishlist.id) }

        it { expect(response).to redirect_to wishlist_products_path(wishlist) }
        it { expect(wishlist.product_wishlists.count).to eq(1) }
        it { expect(flash[:notice]).to be_present }
      end
    end
  end

  context 'unauthenticated' do
    before { get wishlist_products_path(create :wishlist) }

    it { expect(response).to redirect_to(new_user_session_path) }
  end
end