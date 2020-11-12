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
      :lon => south..north,
      :lat => west...east,
    )
  }

  def self.createProduct(params)
    product = Product.create(
      name: params[:product][:name].presence,
      short_code: params[:product][:short_code].presence,
      description: params[:product][:description].presence,
      price01: params[:product][:price01].presence,
      remote_thumbnail: params[:product][:remote_thumbnail].presence,
      thumnail: params[:product][:thumnail].presence,
      address: params[:product][:address].presence,
      bed_rooms: params[:product][:bed_rooms].presence,
      wc: params[:product][:wc].presence, 
      area: params[:product][:area].presence,
      front_area: params[:product][:front_area].presence,
      floors: params[:product][:floors].presence,
      category_id: params[:product][:category_id].presence,
      project_id: params[:product][:project_id].presence,
      pref_id: params[:product][:pref_id].presence,
      uid: params[:product][:uid].presence,
      posted_at: params[:product][:posted_at].presence,
      parsed: params[:product][:parsed].presence,
      parse_url: params[:product][:parse_url].presence,
      short_description: params[:product][:short_description].presence,
      lon: params[:product][:lon].presence,
      lat: params[:product][:lat].presence
    )
    product
  end

  def self.updateProduct(params)
    product = Product.find(params[:id])
    product.update(
      name: params[:product][:name].presence,
      short_code: params[:product][:short_code].presence,
      description: params[:product][:description].presence,
      price01: params[:product][:price01].presence,
      remote_thumbnail: params[:product][:remote_thumbnail].presence,
      thumnail: params[:product][:thumnail].presence,
      address: params[:product][:address].presence,
      bed_rooms: params[:product][:bed_rooms].presence,
      wc: params[:product][:wc].presence, 
      area: params[:product][:area].presence,
      front_area: params[:product][:front_area].presence,
      floors: params[:product][:floors].presence,
      category_id: params[:product][:category_id].presence,
      project_id: params[:product][:project_id].presence,
      pref_id: params[:product][:pref_id].presence,
      uid: params[:product][:uid].presence,
      posted_at: params[:product][:posted_at].presence,
      parsed: params[:product][:parsed].presence,
      parse_url: params[:product][:parse_url].presence,
      short_description: params[:product][:short_description].presence,
      lon: params[:product][:lon].presence,
      lat: params[:product][:lat].presence
    )
    product
  end
end
