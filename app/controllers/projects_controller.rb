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
      response = {project: project}
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

end
