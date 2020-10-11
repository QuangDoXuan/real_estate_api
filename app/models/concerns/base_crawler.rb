require 'open-uri'

class BaseCrawler
  def initialize(url = nil)
    @url = nil
    @html = nil
    if url.present?
      @url = url
      get_html url
    end
  end

  def get_html(link = nil)
    if link.nil?
      Rails.logger.info("debug in get_html in BaseCrawler")
      Rails.logger.info("link is nil")
      Rails.logger.info(@url)
      link = @url
    end
    opt = {}
    opt['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv 11.0) like Gecko'
    opt['allow_redirections'] = "all"
    @html = open(link).read.encode("UTF-16BE", "UTF-8",
                           invalid: :replace,
                           undef: :replace,
                           replace: '.').encode("UTF-8")
    sleep(1)
    self
  end

  def check_html
    if @html.nil?
      if @url.present?
        get_html @url
      else
        raise "html not found"
      end
    end
  end
end
