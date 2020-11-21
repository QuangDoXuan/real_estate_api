namespace :crawler do
  desc "crawl batdongsan.com ban"

  task parse_bds_sell_feed: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_bds_sell_feed")
    
    begin
      bds_api = BdsApi.new
      bds_api.get_products_for_sell
    rescue => e
      Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_bds_sell_feed")
      Rails.logger.error(e)
    end

    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_bds_sell_feed")
  end

  task parse_bds_hire_feed: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_bds_hire_feed")
    
    begin
      bds_api = BdsApi.new
      bds_api.get_products_for_hire
    rescue => e
      Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_bds_hire_feed")
      Rails.logger.error(e)
    end
    
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_bds_hire_feed")
  end

  task parse_product_info: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_product_info")
    
    Product.all.find_each do |product|
      begin
        bds_api = BdsApi.new
        bds_api.parse_product_info product
      rescue => e
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_product_info")
        Rails.logger.error(e)
      end
    end
    
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_product_info")
  end

  task parse_project_info: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_project_info")

    begin
        bds_api = BdsApi.new
        bds_api.get_projects
      rescue => e
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_project_info")
        Rails.logger.error(e)  
    end

    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_project_info")
  end

  task parse_project_detail: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_project_detail")

    Project.all.find_each do |project|
      begin
          bds_api = BdsApi.new
          bds_api.parse_project_info project
        rescue => e
          Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_project_detail")
          Rails.logger.error(e)  
      end
    end

    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_project_detail")
  end

  task parse_products_geocoding: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_products_geocoding")
    
    Product.has_address.last(200).each do |product|
      begin
        bds_api = BdsApi.new
        bds_api.parse_products_geocoding product, product.address
      rescue => e
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_products_geocoding")
        Rails.logger.error(e)  
      end
    end
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_products_geocoding")
  end

  task parse_projects_geocoding: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:parse_projects_geocoding")
    
    Project.has_address.last(200).each do |project|
      begin
        bds_api = BdsApi.new
        bds_api.parse_products_geocoding project, project.address
      rescue => e
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:parse_projects_geocoding")
        Rails.logger.error(e)  
      end
    end
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:parse_projects_geocoding")
  end

  task convert_products_price: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:convert_products_price")

    Product.all.each do |product|
      begin
        BdsProductService.convertPrice(product)
      rescue
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:convert_products_price")
        Rails.logger.error(e)  
      end
    end
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:convert_products_price")
  end

  task convert_products_area: :environment do
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Start crawler:convert_products_area")

    Product.all.each do |product|
      begin
        BdsProductService.convertArea product
      rescue
        Rails.logger.error("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Error in crawler:convert_products_area")
        Rails.logger.error(e)  
      end
    end
    Rails.logger.info("#{Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")} Finish crawler:convert_products_area")
  end

end
