class Company < ApplicationRecord
  has_many :projects
  mount_uploader :thumnail, ThumbnailUploader
  
  def self.createCompany(params)
    company = Company.create(
      name: params[:name].presence,
      address: params[:address].presence,
      phone: params[:phone].presence,
      web_site: params[:web_site].presence,
      aniverse: params[:aniverse].presence,
      field: params[:field].presence,
      fund: params[:fund].presence,
      description: params[:code].presence,
      thumnail: params[:thumnail].presence,
      # image: params[:image].presence,
      slug: params[:slug].presence
    )
    company.image = ENV['URL'] + "/uploads/company/thumnail/" + company.id.to_s + "/" + company.thumnail.url.split("/")[-1]
    company.save
    company
  end

  def self.updateCompany(params)
    company = Company.find(params[:id])
    company.update(
      name: params[:name].presence,
      address: params[:address].presence,
      phone: params[:phone].presence,
      web_site: params[:web_site].presence,
      aniverse: params[:aniverse].presence,
      field: params[:field].presence,
      fund: params[:fund].presence,
      description: params[:code].presence,
      # image: params[:image].presence,
      thumnail: params[:thumnail].presence,
      slug: params[:slug].presence
    )
    company.image = ENV['URL'] + "/uploads/company/thumnail/" + company.id.to_s + "/" + company.thumnail.url.split("/")[-1]
    company.save
    company
  end
end
