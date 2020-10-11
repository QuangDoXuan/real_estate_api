require_relative "environment"

set :environment, Rails.env
set :output, "log/cron_job.log"

every 12.hours do
  rake "crawler:parse_bds_sell_feed"
end
