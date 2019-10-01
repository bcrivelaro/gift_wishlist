RSpec.describe ShoppingCart, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:product_wishlists) }
  end

  describe '#can_checkout?' do
    context 'with product wishlists' do
      let(:shopping_cart) { create :shopping_cart }

      before do
        shopping_cart.product_wishlists << create(:product_wishlist)
        shopping_cart.save
      end

      it { expect(shopping_cart.can_checkout?).to eq(true) }
    end

    context 'without product wishlists' do
      let(:shopping_cart) { create :shopping_cart }

      it { expect(shopping_cart.can_checkout?).to eq(false) }
    end
  end
end
