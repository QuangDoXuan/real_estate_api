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

end
