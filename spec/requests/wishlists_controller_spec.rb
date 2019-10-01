RSpec.describe WishlistsController, type: :request do
  context 'authenticated' do
    let(:user) { create :user }
    let(:valid_params) { { name: 'wishlist' } }
    let(:invalid_params) { { name: '' } }

    before { sign_in user }

    describe 'GET #index' do
      before do
        create_list :wishlist, 2, user: user
        get wishlists_path
      end

      it { expect(response).to be_successful }
      it { expect(assigns(:wishlists).all? { |t| t.is_a? Wishlist }).to eq(true) }
      it { expect(assigns(:wishlists).map(&:user).uniq).to eq([user]) }
    end

    describe 'GET #new' do
      before { get new_wishlist_path }

      it { expect(response).to be_successful }
      it { expect(assigns(:wishlist)).to be_a_new(Wishlist) }
    end

    describe 'POST #create' do
      context 'valid data' do
        it 'creates a new wishlist' do
          expect do
            post wishlists_path, params: { wishlist: valid_params }
          end.to change { user.wishlists.count }.by(1)
        end

        it 'redirects to wishlists path' do
          post wishlists_path, params: { wishlist: valid_params }

          expect(flash[:success]).to be_present
          expect(response).to(
            redirect_to(wishlist_products_path(assigns(:wishlist)))
          )
        end
      end

      context 'invalid data' do
        before { post wishlists_path(params: { wishlist: invalid_params }) }

        it { expect(response).to be_successful }
        it { expect(response).to render_template(:new) }
        it { expect(assigns(:wishlist)).to be_a_new(Wishlist) }
      end
    end

    describe 'GET #edit' do
      let(:wishlist) { create :wishlist, user: user }
      before { get edit_wishlist_path(wishlist) }

      it { expect(response).to be_successful }
      it { expect(assigns(:wishlist)).to eq(wishlist) }
    end

    describe 'PATCH|PUT #update' do
      let(:wishlist) { create :wishlist, user: user }

      context 'valid data' do
        let(:data) { { name: 'new name' } }

        before { put wishlist_path(wishlist), params: { wishlist: data } }

        it do
          expect(response).to(
            redirect_to(wishlist_products_path(assigns(:wishlist)))
          )
        end
        it { expect(flash[:success]).to be_present }
        it { expect(wishlist.reload.name).to eq 'new name' }
      end

      context 'invalid data' do
        before { put wishlist_path(wishlist), params: { wishlist: invalid_params } }

        it { expect(response).to render_template(:edit) }
        it { expect(assigns(:wishlist)).to eq(wishlist) }
        it { expect(assigns(:wishlist).errors).to be_present }
      end
    end

    describe 'DELETE #destroy' do
      let(:wishlist) { create :wishlist, user: user }
      before { delete wishlist_path(wishlist) }

      it { expect(response).to redirect_to(wishlists_path) }
      it { expect(flash[:success]).to be_present }
      it { expect(user.wishlists.count).to eq(0) }
    end
  end

  context 'unauthenticated' do
    before { get wishlists_path }

    it { expect(response).to redirect_to(new_user_session_path) }
  end
end
