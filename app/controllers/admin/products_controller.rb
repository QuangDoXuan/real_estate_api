class Admin::ProductsController < ApplicationController
  before_action :authorize_request

  def index
    page = params[:page] || 1
    per = params[:per] || 20
    type = params[:type]
    @products = Product.for_sell.page(page).per(per) if params[:type] == "1"
    @products = Product.for_hire.page(page).per(per) if params[:type] == "2"

    render json: @products, status: :ok
  end

  def show
    @product = Product.find(params[:id])
    render json: @products, status: :ok
  end

  # def create
  #   product = Product.create(
  #     name: params[:name] || nil,
  #     address: params[:address] || nil,
  #     price
  #   )
  # end

end