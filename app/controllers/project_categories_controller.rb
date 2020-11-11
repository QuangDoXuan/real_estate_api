class ProjectCategoriesController < ApplicationController
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    project_categories = ProjectCategory.page(page).per(per)
    render json: project_categories, status: :ok
  end

  def create
    project_category = ProjectCategory.create(name: params[:name].presence)
    if project_category.present?
      response = {project_category: project_category}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def show
    project_category = ProjectCategory.find(params[:id])
    render json: project_category, status: :ok if project_category.present?
  end

  def update
    project_category = ProjectCategory.find(params[:id])
    project_category.update(name: params[:name].presence)
    response = {project_category: project_category}
    render json: response, status: :ok
  end

  def destroy
    project_category = ProjectCategory.find(params[:id])
    if project_category.present?
      project_category.delete
      response = {delete_status: 'complete'}
      render json: response, status: :ok
    end
  end
end
