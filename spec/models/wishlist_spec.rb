RSpec.describe Wishlist, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'callbacks' do
    it 'generates a token when creating' do
      wishlist = Wishlist.new(user: create(:user), name: 'name')

      wishlist.save

      expect(wishlist.token).to be_present
    end
  end
end
