class Category < ApplicationRecord
  has_many :products
  belongs_to :parent, optional: true, class_name: 'Category'
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  validates :name, uniqueness: true

  scope :top_level, -> { where(parent: nil) }

  def self_and_descendents_ids
    [id] + descendants_ids
  end

  def descendants_ids
    Category.where(parent: self).map do |child|
      [child.id] + child.descendants_ids
    end.flatten
  end
end
