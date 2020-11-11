class Company < ApplicationRecord
  has_many :projects
  
  def self.createCompany(params)
    company = Company.create(
      name: params[:company][:name].presence,
      address: params[:company][:address].presence,
      phone: params[:company][:phone].presence,
      web_site: params[:company][:web_site].presence,
      aniverse: params[:company][:aniverse].presence,
      field: params[:company][:field].presence,
      fund: params[:company][:fund].presence,
      description: params[:company][:code].presence,
      image: params[:company][:image].presence,
      slug: params[:company][:slug].presence
    )
    company
  end

  def self.updateCompany(params)
    company = Company.find(params[:id])
    company.update(
      name: params[:company][:name].presence,
      address: params[:company][:address].presence,
      phone: params[:company][:phone].presence,
      web_site: params[:company][:web_site].presence,
      aniverse: params[:company][:aniverse].presence,
      field: params[:company][:field].presence,
      fund: params[:company][:fund].presence,
      description: params[:company][:code].presence,
      image: params[:company][:image].presence,
      slug: params[:company][:slug].presence
    )
    company
  end
end
