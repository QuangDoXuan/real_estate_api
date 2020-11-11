class ProductsController < ApplicationController
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 20
    type = params[:type]
    @products = Product.for_sell.page(page).per(per) if params[:type] == "1"
    @products = Product.for_hire.page(page).per(per) if params[:type] == "2"

    render json: @products, status: :ok
  end

  def create
    product = Product.createProduct(params)
    product_images = []
    params[:product_images].each do |img|
      product_img = ProductImage.createProductImage(img, product.id)
      product_images << product_img
    end
    if product.present?
      response = {product: product, product_images: product_images}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def show
    product = Product.find(params[:id])
    if product.present?
      product_images = product.product_images
      response = {product: product, product_images: product_images}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def update
    product = Product.updateProduct(params)
    params[:product_images].each do |img|
      ProductImage.updateProductImage(img, product.id)
    end
    response = {product: product, product_images: product.product_images}
    render json: response, status: :ok
  end

  def destroy
    product = Product.find(params[:id])
    if product.present?
      product.product_images.each do |img|
        img.delete
      end
      product.delete
      response = {delete_status: 'complete'}
      render json: response, status: :ok
    end
  end

  def map
    north = params[:north]
    south = params[:south]
    east = params[:east]
    west = params[:west]

    @products = Product.geo_search(north, south, east, west)

    render json: @products, status: :ok
  end

end
