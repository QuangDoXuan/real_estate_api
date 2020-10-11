class BdsProductService

  def self.save_from_api(product, category_id)
    return false if category_id.nil?
    product = Product.create_with(
      name: product.css('.product-title .product-link')[0].content || nil,
      uid: product['uid'].to_i,
      description: product.css('.product-content')[0].to_s || nil,
      price01: product.css('.product-info .price')[0].content || nil,
      area: product.css('.product-info .area')[0].present? ? product.css('.product-info .area')[0].content : nil,
      address: product.css('.product-info .location')[0].content || nil,
      remote_thumbnail: product.css('.product-avatar-img')[0]['src'] || nil,
      posted_at: product.css('.tooltip-time')[0].content.to_time || nil,
      category_id: category_id
    ).find_or_create_by(
      uid: product['uid'].to_i
    )
    product.save
    sleep(1 + rand(1))
  end
end
  