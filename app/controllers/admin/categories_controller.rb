class Admin::CategoriesController < ApplicationController
  before_action :authorize_request

  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    categories = Category.has_parent.order('parent_category_type ASC').page(page).per(per)
    render json: categories, status: :ok
  end

  def create
    category = Category.create(name: params[:name].presence, parent_category_type: params[:parent_category_type].presence)
    if category.present?
      response = {category: category}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def show
    category = Category.find(params[:id])
    if category.present?
      response = {category: category, products: category.products}
      render json: response, status: :ok
    else
      render json: response, status: :not_found
    end
  end

  def update
    category = Category.find(params[:id])
    category.update(name: params[:name].presence, parent_category_type: params[:parent_category_type].presence)
    response = {category: category}
    render json: response, status: :ok
  end

  # def destroy
  #   category = Category.find(params[:id])
  # end
end
