class Project < ApplicationRecord
  has_many :products
  belongs_to :company, optional: true

  scope :not_parsed, -> {
    where('project_category_id IS NULL' )
  }
end
