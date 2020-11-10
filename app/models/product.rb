class Product < ApplicationRecord
  belongs_to :category
  belongs_to :project, optional: true
  belongs_to :category, optional: true
  belongs_to :pref, optional: true
  has_many :product_images

  scope :not_parsed, -> { where('parsed IS NULL OR parsed = ?', 0) }

  scope :for_hire, -> {
    joins(:category)
    .where('categories.parent_category_type = ?', 2)
    .order('products.id asc')
  }

  scope :for_sell, -> {
    joins(:category)
    .where('categories.parent_category_type = ?', 1)
    .order('products.id asc')
  }

  scope :has_address, -> {
    where('address IS NOT NULL')
    .where('lon IS NULL')
    .where('lat IS NULL')
  }

  scope :geo_search, -> (north, south, east, west) {
    where(
      :lat => south..north,
      :lon => west...east,
    )
  }

end
