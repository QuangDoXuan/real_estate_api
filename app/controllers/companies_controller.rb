class CompaniesController < ApplicationController
  # GET /

  def index
    page = params[:page] || 1
    per = params[:per] || 10
    companies = Company.page(page).per(per)
    render json: companies, status: :ok
  end

  def create
    company = Company.createCompany(params)
    if company.present?
      response = {company: company}
      render json: response, status: :ok
    else
      response = {}
      render json: response, status: :not_found
    end
  end

  def show
    company = Company.find(params[:id])
    if company.present?
      response = {company: company, projects: company.projects}
      render json: response, status: :ok
    else
      render json: response, status: :not_found
    end
  end

  def update
    company = Company.updateCompany(params)
    response = {company: company}
    render json: response, status: :ok
  end

  def get_all_projects
    company = Company.find(params[:id])
    if company.present?
      projects = company.projects
      render json: projects, status: :ok
    else
      render json: [], status: :ok
    end
  end
end
