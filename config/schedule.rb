require_relative "environment"

set :environment, Rails.env
set :output, "log/cron_job.log"

every 12.hours do
  rake "crawler:parse_bds_sell_feed"
  rake "crawler:parse_bds_hire_feed"
end

every 6.hours do
  # rake "crawler:parse_product_info"
end
