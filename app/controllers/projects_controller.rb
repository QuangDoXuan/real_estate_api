class ProjectsController < ApplicationController
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    @projects = Project.with_company.page(page).per(per)
    render json: @projects, status: :ok
  end

  def create
    project = Project.createProject(params)
    project_images = []
    params[:project_images].each do |img|
      project_img = ProjectImage.createProjectImage(img, project.id)
      project_images << project_img
    end
    if project.present?
      response = {project: project, project_images: project_images}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def show
    project = Project.find(params[:id])
    if project.present?
      response = {project: project, project_images: project.project_images, company: project.company}
      render json: response, status: :ok
    end
  end

  def update
    project = Project.updateProject(params)
    params[:project_images].each do |img|
      ProjectImage.updateProjectImage(img, project.id)
    end
    response = {project: project, project_images: project.project_images}
    render json: response, status: :ok
  end

  def destroy
    project = Project.find(params[:id])
    if project.present?
      project.project_images.each do |img|
        img.delete
      end
      project.delete
      response = {delete_status: 'complete'}
      render json: response, status: :ok
    end
  end

  def get_all_product
    id = params[:id]
    page = params[:page] || 1
    per = params[:per] || 20
    project = Project.find(id)

    products = project.products.page(page).per(per)
    render json: products, status: :ok
  end

  def get_by_name
    name = params[:name]
    projects = Project.search_by_name(name)

    render json: projects, status: :ok
  end

end
