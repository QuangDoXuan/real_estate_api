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
    
    Product.not_parsed.find_each do |product|
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

end
