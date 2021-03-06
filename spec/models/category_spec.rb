RSpec.describe Category, type: :model do
  describe 'associations' do
    it { should have_many(:products) }
    it { should belong_to(:parent).optional.class_name('Category') }
    it { should have_many(:children).class_name('Category') }
  end

  describe 'validations' do
    subject { build :category }

    it { should validate_uniqueness_of(:name) }
  end

  describe '.top_level' do
    it 'returns only categories without parent' do
      cat1 = create :category
      cat2 = create :category
      create :category, parent: cat1
      create :category, parent: cat2

      expect(Category.top_level).to match_array([cat1, cat2])
    end
  end

  describe '#self_and_descendents_ids' do
    context 'with multi level descendants' do
      it 'returns self and descendants ids' do
        cat1 = create :category
        cat2 = create :category, parent: cat1
        cat3 = create :category, parent: cat2
        cat4 = create :category, parent: cat3
        cat5 = create :category, parent: cat4

        expect(cat1.self_and_descendents_ids).to(
          match_array([cat1, cat2, cat3, cat4, cat5].map(&:id))
        )
      end
    end

    context 'with one level descendants' do
      it 'returns self and descendants' do
        cat1 = create :category
        cat2 = create :category, parent: cat1

        expect(cat1.self_and_descendents_ids).to match_array([cat1.id, cat2.id])
      end
    end

    context 'with no descendants' do
      it 'returns empty array' do
        cat = create :category

        expect(cat.self_and_descendents_ids).to match_array([cat.id])
      end
    end
  end
end
