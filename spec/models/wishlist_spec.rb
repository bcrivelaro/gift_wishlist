RSpec.describe Wishlist, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:product_wishlists).dependent(:destroy) }
    it { should have_many(:products).through(:product_wishlists) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
