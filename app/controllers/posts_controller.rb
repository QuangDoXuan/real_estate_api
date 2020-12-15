class PostsController < ApplicationController
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    posts = Post.page(page).per(per)
    render json: posts, status: :ok
  end

  def show
    project_category = ProjectCategory.find(params[:id])
    render json: project_category, status: :ok if project_category.present?
  end
end
