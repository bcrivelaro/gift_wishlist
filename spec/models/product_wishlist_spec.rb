RSpec.describe ProductWishlist, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:wishlist) }
    it { should have_and_belong_to_many(:shopping_carts) }
  end

  describe '#can_be_destroyed?' do
    context 'bought is false' do
      subject { build(:product_wishlist, bought: false).can_be_destroyed? }

      it { is_expected.to eq(true) }
    end

    context 'bought is true' do
      subject { build(:product_wishlist, bought: true).can_be_destroyed? }

      it { is_expected.to eq(false) }
    end
  end
end
