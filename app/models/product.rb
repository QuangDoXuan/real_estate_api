class Product < ApplicationRecord
  belongs_to :category
  belongs_to :project, optional: true
  belongs_to :category, optional: true
  belongs_to :pref, optional: true
  has_many :product_images

  scope :not_parsed, -> { where('parsed IS NULL OR parsed = ?', 0) }

end
