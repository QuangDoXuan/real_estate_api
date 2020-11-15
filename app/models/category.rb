class Category < ApplicationRecord
  has_many :products

  scope :has_parent, -> {
    where('parent_category_type IS NOT NULL')
  }
end
