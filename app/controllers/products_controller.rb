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

  def show
    product = Product.find(params[:id])
    if product.present?
      product_images = product.product_images
      project = product.project
      response = {product: product, product_images: product_images, project: project}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
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
