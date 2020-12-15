class Admin::CompaniesController < ApplicationController
  before_action :authorize_request
  # GET /
  def index
    page = params[:page] || 1
    per = params[:per] || 10
    companies = Company.order('id DESC').page(page).per(per)
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

  def destroy
    company = Company.find(params[:id])
    company.delete
    response = {done: true}
    render json: response, status: :ok
  end

  def get_by_name
    page = params[:page] || 1
    per = params[:per] || 5
    name = params[:name]
    projects = Company.search_by_name(name).page(page).per(per)

    render json: projects, status: :ok
  end


end
