class Category < ApplicationRecord
  belongs_to :parent, optional: true, class_name: 'Category'

  validates :name, uniqueness: true

  scope :top_level, -> { where(parent: nil) }

  def descendants
    Category.where(parent: self).map do |child|
      [child] + child.descendants
    end.flatten
  end
end
