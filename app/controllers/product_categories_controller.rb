class ProductCategoriesController < ApplicationController
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
    category = Category.find(params[:id])
    render json: category, status: :ok if category.present?
  end
end
