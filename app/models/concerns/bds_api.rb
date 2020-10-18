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
        category = Category.create_with(
          name: category_name,
          parent_category_type: product.category_id
        ).find_or_create_by(
          name: category_name
        )
      end
      if doc.at('.r1:contains("Tên dự án:")').present?
        project_name = doc.at('.r1:contains("Tên dự án:")').next.children.first.content.gsub("\n", "").strip
        project = Project.create_with(
          name: project_name,
        ).find_or_create_by(
          name: project_name
        )
        project.slug_url = doc.at('.r1:contains("Tên dự án:")').next.children.css('a').first['href']
        project.save
      end

      if category.present?
        product.update(
          short_code: doc.css('.product-config .sp3')[-1].content,
          bed_rooms: doc.at('.sp2:contains("PN")').present? ? doc.at('.sp2:contains("PN")').text.strip.gsub('PN','').to_i : nil,
          category_id: category.id || nil,
          project_id: project.present? ? project.id : nil,
          parsed: 1
        )
      end

      doc.css('li.swiper-slide a').each do |slide|
        ProductImage.create(
          product_id: product.id,
          name: slide['style'].gsub('background-image:url','').gsub('(','').gsub(')','')
        )
      end

    end
  end
end
