class Project < ApplicationRecord
  has_many :products
  belongs_to :company, optional: true
  attribute :company_name, :string
  attribute :company_slug, :string

  scope :not_parsed, -> {
    where('project_category_id IS NULL' )
  }
  scope :with_company, -> {
    joins(:company)
    .select('projects.*', 'companies.name as company_name', 'companies.slug as company_slug')
  }

  scope :has_address, -> {
    where('address IS NOT NULL')
    .where('lon IS NULL')
    .where('lat IS NULL')
  }
end
