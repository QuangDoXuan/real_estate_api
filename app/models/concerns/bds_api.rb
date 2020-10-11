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
    for i in 1..5 do
      url = "https://batdongsan.com.vn/nha-dat-ban-ha-noi/p#{i}"
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      doc.css('.product-item').each do |product|
        BdsProductService.save_from_api(product, 1)
      end
    end
  end

  def get_products_for_hire
    for i in 1..5 do
      url = "https://batdongsan.com.vn/nha-dat-cho-thue-ha-noi/p#{i}"
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      doc.css('.product-item').each do |product|
        BdsProductService.save_from_api(product, 2)
      end
    end
  end

  def parse_product_info product
    if product.parse_url.present?
      url = "https://batdongsan.com.vn" + product.parse_url
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      if doc.css('.detail-2 .row-1 .r2').first.present?
        category_name = doc.css('.detail-2 .row-1 .r2').first.content
        category = Category.find_by_name(doc.css('.detail-2 .row-1 .r2').first.content)
        category = Category.find_or_create_by(
          name: category_name,
          parent_category_type: product.category_id
        )
      end

      if doc.at('.r1:contains("Tên dự án:")').present?
        project_name = doc.at('.r1:contains("Tên dự án:")').next.content.gsub(/[^0-9A-Za-z]/, '').gsub('Xemdn', '') 
        project = Project.find_or_create_by(
          name: project_name
        )
      end

      if category.present?
        product.update(
          short_code: doc.css('.product-config .sp3')[-1].content,
          bed_rooms: doc.at('.sp2:contains("PN")').present? ? doc.at('.sp2:contains("PN")').text.strip.gsub('PN','').to_i : nil,
          category_id: category.id,
          project_id: project.id || nil,
          parsed: 1
        )
      end

    end
  end
end
