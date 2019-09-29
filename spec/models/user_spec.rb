RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:wishlists) }
  end
end
