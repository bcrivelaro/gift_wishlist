class Category < ApplicationRecord
  has_many :products
  belongs_to :parent, optional: true, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  validates :name, uniqueness: true

  scope :top_level, -> { where(parent: nil) }

  def descendants
    Category.where(parent: self).map do |child|
      [child] + child.descendants
    end.flatten
  end
end
