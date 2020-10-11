require 'open-uri'

class BdsApi < BaseCrawler
  def initialize()
    super(nil)
  end

  def get_projects
    file_path = File.dirname(__FILE__)+"/datas/projects.html"
    html = File.open(file_path).read
    doc = Nokogiri::HTML html
    doc.css('ul li').each do |item|
      Project.create(
        name: item.content,
        code: item['vl']
      )
    end
  end

  def get_products_for_sell
    for i in 1..10 do
      url = "https://batdongsan.com.vn/nha-dat-ban-ha-noi/p#{i}"
      get_html url
      doc = Nokogiri::HTML @html
      doc.css('.vip0.product-item').each do |product|
        BdsProductService.save_from_api(product, 1)
      end
      next
    end
  end
end
