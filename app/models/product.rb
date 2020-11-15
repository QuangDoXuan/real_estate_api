class Product < ApplicationRecord
  has_many :product_images
  mount_uploader :thumnail, ThumbnailUploader
  accepts_nested_attributes_for :product_images, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }
  belongs_to :category
  belongs_to :project, optional: true
  belongs_to :category, optional: true
  belongs_to :pref, optional: true

  attribute :category_name, :string
  enum is_remote: {remote: 0, system: 1}

  scope :not_parsed, -> { where('parsed IS NULL OR parsed = ?', 0) }

  scope :for_hire, -> {
    joins(:category)
    .where('categories.parent_category_type = ?', 2)
    .order('products.id desc')
    .select('products.*', 'categories.name as category_name')
  }

  scope :for_sell, -> {
    joins(:category)
    .where('categories.parent_category_type = ?', 1)
    .order('products.id desc')
    .select('products.*', 'categories.name as category_name')
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
      name: params[:name].presence,
      short_code: params[:short_code].presence,
      description: params[:description].presence,
      price01: params[:price01].presence,
      # remote_thumbnail: params[:remote_thumbnail].presence,
      thumnail: params[:thumnail].presence,
      address: params[:address].presence,
      bed_rooms: params[:bed_rooms].presence,
      wc: params[:wc].presence, 
      area: params[:area].presence,
      front_area: params[:front_area].presence,
      floors: params[:floors].presence,
      category_id: params[:category_id].presence,
      project_id: params[:project_id].presence,
      pref_id: params[:pref_id].presence,
      uid: params[:uid].presence,
      posted_at: params[:posted_at].presence,
      parsed: params[:parsed].presence,
      parse_url: params[:parse_url].presence,
      short_description: params[:short_description].presence,
      lon: params[:lon].presence,
      lat: params[:lat].presence,
      is_remote: :system
    )
    product.remote_thumbnail = ENV['URL'] + "/uploads/product/thumnail/" + product.id.to_s + "/" + product.thumnail.url.split("/")[-1]
    product.save
    product
  end

  def self.updateProduct(params)
    product = Product.find(params[:id])
    product.update(
      name: params[:name].presence,
      short_code: params[:short_code].presence,
      description: params[:description].presence,
      price01: params[:price01].presence,
      remote_thumbnail: params[:remote_thumbnail].presence,
      thumnail: params[:thumnail].presence,
      address: params[:address].presence,
      bed_rooms: params[:bed_rooms].presence,
      wc: params[:wc].presence, 
      area: params[:area].presence,
      front_area: params[:front_area].presence,
      floors: params[:floors].presence,
      category_id: params[:category_id].presence,
      project_id: params[:project_id].presence,
      pref_id: params[:pref_id].presence,
      uid: params[:uid].presence,
      posted_at: params[:posted_at].presence,
      parsed: params[:parsed].presence,
      parse_url: params[:parse_url].presence,
      short_description: params[:short_description].presence,
      lon: params[:lon].presence,
      lat: params[:lat].presence
    )
    product.remote_thumbnail = ENV['URL'] + "/uploads/product/thumnail/" + product.id.to_s + "/" + product.thumnail.url.split("/")[-1]
    product.save
    product
  end
end
