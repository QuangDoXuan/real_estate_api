class BdsProductService

  def self.save_from_api(product, category_id)
    return false if category_id.nil?
    if product.css('.thumb-image').first.present?
      product = Product.create_with(
        name: product.css('.title').first.present? ? product.css('.title').first.text : nil,
        short_code: product.css('.thumb-image').first['href'].split('-')[-1],
        parse_url: product.css('.thumb-image').first['href'],
        short_description: product.css('.description').first.present? ? product.css('.description').first.text : nil,
        price01: product.css('.price').first.present? ? product.css('.price').first.text : nil,
        area: product.css('.acreage').first.present? ? product.css('.acreage').first.text : nil,
        address: product.css('.address').first.present? ? product.css('.address').first.text : nil,
        remote_thumbnail: product.css('.thumb-image img').first.present? ? product.css('.thumb-image img').first['src'] : nil,
        category_id: category_id
      ).find_or_create_by(
        short_code: product.css('.thumb-image').first['href'].split('-')[-1],
        category_id: category_id
      )
    end
  end

  def self.convertPrice(product)
    if product.price01.present? 
      if product.category.parent_category_type == 1
        if product.price01.include? "Tỷ"
          product.price02 = product.price01.gsub("Tỷ", '').to_i * 1000000000

        elsif product.price01.include? "Triệu"
          product.price02 = product.price01.gsub("Triệu", '').to_i * 1000000
        end
        product.save
      else
        if product.price01.include? "Triệu/tháng"
          product.price02 = product.price01.gsub("Triệu/tháng",'').to_i * 1000000
        end
        product.save
      end
    end
  end

  def self.convertArea product
    if product.area.present?
      product.area02 = product.area.gsub("m2",'').to_i
      product.save
    end
  end

end
