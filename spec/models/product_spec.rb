RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:product_wishlists).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build :product }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end
end
