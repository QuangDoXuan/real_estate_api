class ProjectsController < ApplicationController
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    @projects = Project.with_company.page(page).per(per)
    render json: @projects, status: :ok
  end
end
