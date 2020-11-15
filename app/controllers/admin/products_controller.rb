class Admin::ProductsController < ApplicationController
  before_action :authorize_request

  def index
    page = params[:page] || 1
    per = params[:per] || 20
    type = params[:type]

    @products = Product.for_sell.order('id DESC').page(page).per(per) if params[:type] == "1"
    @products = Product.for_hire.order('id DESC').page(page).per(per) if params[:type] == "2"
    @products = Product.all.order('id DESC').page(page).per(per) if params[:type] == "0"
    # @products.each do |product|
    #   product.category = product.category
    # end

    render json: @products, status: :ok
  end

  def show
    @product = Product.find(params[:id])
    render json: @products, status: :ok
  end


  def create
    ActiveRecord::Base.transaction do
      product = Product.createProduct(params)
      byebug
      params[:product_images].each do |img|
        ProductImage.createProductImage(img, product.id)
      end

      if product.present?
        response = {product: product, product_images: product.product_images}
        render json: response, status: :ok
      else
        response = {}
        render json: response, status: :not_found
      end

    end
  end

  # def show
  #   product = Product.find(params[:id])
  #   if product.present?
  #     product_images = product.product_images
  #     response = {product: product, product_images: product_images}
  #     render json: response, status: :ok
  #   else
  #     response = {}
  #     render json: response, status: :not_found
  #   end
  # end

  def update
    product = Product.updateProduct(params)
    # params[:product_images].each do |img|
    #   ProductImage.updateProductImage(img, product.id)
    # end
    response = {product: product}
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

  private
  def product_params
    params.require(:product).permit(:name, product_images_attributes: 
    [:id, :product_id, :image])
  end

end