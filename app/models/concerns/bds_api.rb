require 'open-uri'

class BdsApi < BaseCrawler
  def initialize()
    super(nil)
  end

  def get_projects
    for i in 1..10 do
      url = "https://homedy.com/du-an-ha-noi/p#{i}"
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      doc.css(".tab-content .item").each do |item|
        project_ids = []
        if item.css(".name-investory").first.present?
          company = Company.find_or_create_by(
            name: item.css(".name-investory").first.text.strip
          )
        end

        item.css('.category li').each do |pj_category|
          prj = ProjectCategory.find_or_create_by(
            name: pj_category.text.strip
          )
          project_ids << prj.id
        end
        if company.present?
          Project.create_with(
            name: item.css(".info h2").first.present? ? item.css(".info h2").first.text.gsub("\r","").gsub("\n","").strip : nil,
            address: item.css(".info .address").first.present? ? item.css(".info .address").first.text : nil,
            total_area: item.css(".icon-acreage").first.parent.children.css('.name-item').first.present? ? item.css(".icon-acreage").first.parent.children.css('.name-item').first.text : nil,
            code: item.css(".thumb-image a").first.present? ? item.css(".thumb-image a").first["href"].split("-")[-1] : nil,
            slug: item.css(".thumb-image a").first.present? ? item.css(".thumb-image a").first["href"] : nil,
            image: item.css(".thumb-image img").first.present? ? item.css(".thumb-image img").first["src"] : nil,
            release_at: item.css(".icon-time").first.parent.children.css('.name-item').first.present? ? item.css(".icon-time").first.parent.children.css('.name-item').first.text.gsub("Bàn giao:","").strip : nil,
            build_status: item.css(".icon-status").first.parent.children.css('.name-item').first.present? ? item.css(".icon-status").first.parent.children.css('.name-item').first.text : nil,
            status: item.css(".status").first.present? ? item.css(".status").first.text.strip : nil,
            price_range: item.css(".price-range").first.present? ? item.css(".price-range").first.text.strip : nil,
            pricem2: item.css(".price").first.present? ? item.css(".price").first.text.strip : nil,
            project_category_ids: project_ids.to_s || nil,
            company_id: company.id || nil
          ).find_or_create_by(
            name: item.css(".info h2").first.present? ? item.css(".info h2").first.text.gsub("\r","").gsub("\n","").strip : nil,
            code: item.css(".thumb-image a").first["href"].split("-")[-1]
          )
        end
      end
    end
  end

  def get_products_for_sell
    for i in 1..10 do
      url = "https://homedy.com/ban-nha-dat-ha-noi/p#{i}"
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      doc.css('.product-item').each do |product|
        BdsProductService.save_from_api(product, 1)
      end
    end
  end

  def get_products_for_hire
    for i in 1..10 do
      url = "https://homedy.com/cho-thue-nha-dat-ha-noi/p#{i}"
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      doc.css('.product-item').each do |product|
        BdsProductService.save_from_api(product, 2)
      end
    end
  end

  def parse_product_info product
    if product.parse_url.present?
      url = "https://homedy.com/" + product.parse_url
      form_res = Faraday.get url
      doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
      category = Category.find_or_create_by(
        name: doc.css('.breadcrumb li')[2].text.strip,
      )
      if doc.css('.type-name').text.strip == "Bán"
        category.parent_category_type = 1
      elsif doc.css('.type-name').text.strip == "Cho thuê"
        category.parent_category_type = 2
      end
      category.save

      project = Project.find_or_create_by(
        name: doc.css('.product-project-bg .info .name').text.strip
      )
      doc.css('.owl-lazy').each do |image|
        product_image = ProductImage.find_or_create_by(
          product_id: product.id,
          name: image['data-src']
        )
      end

      product.category_id = category.id
      product.project_id = project.id
      product.description = doc.css("#readmore").to_s.gsub("\n","").gsub("\r","")
      product.parsed = 1
      product.save
    end
  end

  def parse_project_info project
    slug = project.name.mb_chars.normalize(:kd).gsub('đ', 'd').gsub(/[^\x00-\x7F]/n,'').downcase.to_s.gsub(" ", "-")
    url = "https://homedy.com/#{slug}-#{project.code}"
    form_res = Faraday.get url
    doc = Nokogiri::HTML.parse(form_res.body, nil, "utf-8")
    project_categories = []
    # bye
    # docbug.css('.ls-address').text.strip
    # doc.css('.price .price-total span').text.strip
    # doc.css('.price .price-unit span').text.strip
    # doc.css('.avatar img').first['src']
    # company-name : doc.css('.iname').text.strip
    # doc.css('.txt-text:contains("Diện tích khu đất:")').first.parent.children.css('.txt-bule').first.text
    # doc.css('label:contains("Trạng thái:")').first.parent.children.css('a').text
    # doc.css('.txt-text:contains("Thời gian hoàn thành:")').first.parent.children.css('.txt-bule').first.text
    # doc.css('.description-content').to_s.gsub("\r","").gsub("\n","")
    # doc.css('.image-default').first['style'].gsub("background: url(","").gsub(")","")
    if doc.css('.iname').present?
      company = Company.find_or_create_by(
        name: doc.css('.iname').text.strip
      )

      project.address = doc.css('.ls-address').present? ? doc.css('.ls-address').text.strip : ""
      project.price_range = doc.css('.price .price-total span').present? ? doc.css('.price .price-total span').text.strip : ""
      project.pricem2 = doc.css('.price .price-unit span').present? ? doc.css('.price .price-unit span').text.strip : ""
      project.image = doc.css('.avatar img').first['src']
      project.area = doc.css('.txt-text:contains("Diện tích khu đất:")').first.parent.children.css('.txt-bule').first.present? ? doc.css('.txt-text:contains("Diện tích khu đất:")').first.parent.children.css('.txt-bule').first.text : ""
      project.status = doc.css('label:contains("Trạng thái:")').first.parent.children.css('a').present? ? doc.css('label:contains("Trạng thái:")').first.parent.children.css('a').text : ""
      project.description = doc.css('.description-content').present? ? doc.css('.description-content').to_s.gsub("\r","").gsub("\n","") : ""
      project.release_at = doc.css('.txt-text:contains("Thời gian hoàn thành:")').first.parent.children.css('.txt-bule').first.present? ? doc.css('.txt-text:contains("Thời gian hoàn thành:")').first.parent.children.css('.txt-bule').first.text : ""

      doc.css('.category a').each do |category|

        pj_category = ProjectCategory.find_or_create_by(
          name: category.text.strip
        )
        project_categories << pj_category.id
      end
      project.project_category_ids = project_categories.to_s
      project.save

      doc.css('.i-item img').each do |pj_image|
        pj_image = ProjectImage.find_or_create_by(
          name: pj_image['src'],
          project_id: project.id
        )
      end

    end
  end
end
