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
end
