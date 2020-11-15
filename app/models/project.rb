class Project < ApplicationRecord
  has_many :products
  has_many :project_images
  belongs_to :company, optional: true
  attribute :company_name, :string
  attribute :company_slug, :string
  mount_uploader :thumnail, ThumbnailUploader

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
      name: params[:name].presence,
      address: params[:address].presence,
      area: params[:area].presence,
      building_density: params[:building_density].presence,
      place: params[:place].presence,
      infras: params[:infras].presence,
      scale: params[:scale].presence,
      code: params[:code].presence,
      slug: params[:slug].presence,
      thumnail: params[:thumnail].presence,
      slug_url: params[:slug_url].presence,
      pricem2: params[:pricem2].presence,
      status: params[:status].presence,
      release_at: params[:release_at].presence,
      build_status: params[:build_status].presence,
      price_range: params[:price_range].presence,
      project_category_ids: params[:project_category_ids].presence,
      company_id: params[:company_id].presence,
      total_area: params[:total_area].presence,
      description: params[:description].presence,
      lon: params[:lon].presence,
      lat: params[:lat].presence
    )
    project.image = ENV['URL'] + "/uploads/project/thumnail/" + project.id.to_s + "/" + project.thumnail.url.split("/")[-1]
    project.save
    project
  end

  def self.updateProject(params)
    project = Project.find(params[:id])
    project.update(
      name: params[:name].presence,
      address: params[:address].presence,
      area: params[:area].presence,
      building_density: params[:building_density].presence,
      place: params[:place].presence,
      infras: params[:infras].presence,
      scale: params[:scale].presence,
      code: params[:code].presence,
      slug: params[:slug].presence,
      thumnail: params[:thumnail].presence,
      slug_url: params[:slug_url].presence,
      pricem2: params[:pricem2].presence,
      status: params[:status].presence,
      release_at: params[:release_at].presence,
      build_status: params[:build_status].presence,
      price_range: params[:price_range].presence,
      project_category_ids: params[:project_category_ids].presence,
      company_id: params[:company_id].presence,
      total_area: params[:total_area].presence,
      description: params[:description].presence,
      lon: params[:lon].presence,
      lat: params[:lat].presence
    )
    project.image = ENV['URL'] + "/uploads/project/thumnail/" + project.id.to_s + "/" + project.thumnail.url.split("/")[-1]
    project.save
    project
  end
end
