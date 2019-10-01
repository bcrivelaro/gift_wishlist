RSpec.describe ShoppingCart, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:product_wishlists) }
  end
end
