class Project < ApplicationRecord
  has_many :products
  has_many :project_images
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

  def self.createProject(params)
    project = Project.create(
      name: params[:project][:name].presence,
      address: params[:project][:address].presence,
      area: params[:project][:area].presence,
      building_density: params[:project][:building_density].presence,
      place: params[:project][:place].presence,
      infras: params[:project][:infras].presence,
      scale: params[:project][:scale].presence,
      code: params[:project][:code].presence,
      slug: params[:project][:slug].presence,
      image: params[:project][:image].presence,
      slug_url: params[:project][:slug_url].presence,
      pricem2: params[:project][:pricem2].presence,
      status: params[:project][:status].presence,
      release_at: params[:project][:release_at].presence,
      build_status: params[:project][:build_status].presence,
      price_range: params[:project][:price_range].presence,
      project_category_ids: params[:project][:project_category_ids].presence,
      company_id: params[:project][:company_id].presence,
      total_area: params[:project][:total_area].presence,
      description: params[:project][:description].presence,
      lon: params[:project][:lon].presence,
      lat: params[:project][:lat].presence
    )
    project
  end

  def self.updateProject(params)
    project = Project.find(params[:id])
    project.update(
      name: params[:project][:name].presence,
      address: params[:project][:address].presence,
      area: params[:project][:area].presence,
      building_density: params[:project][:building_density].presence,
      place: params[:project][:place].presence,
      infras: params[:project][:infras].presence,
      scale: params[:project][:scale].presence,
      code: params[:project][:code].presence,
      slug: params[:project][:slug].presence,
      image: params[:project][:image].presence,
      slug_url: params[:project][:slug_url].presence,
      pricem2: params[:project][:pricem2].presence,
      status: params[:project][:status].presence,
      release_at: params[:project][:release_at].presence,
      build_status: params[:project][:build_status].presence,
      price_range: params[:project][:price_range].presence,
      project_category_ids: params[:project][:project_category_ids].presence,
      company_id: params[:project][:company_id].presence,
      total_area: params[:project][:total_area].presence,
      description: params[:project][:description].presence,
      lon: params[:project][:lon].presence,
      lat: params[:project][:lat].presence
    )
    project
  end
end
