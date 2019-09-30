RSpec.describe ProductWishlist, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:wishlist) }
  end
end
