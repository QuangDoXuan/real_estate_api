class ProductImage < ApplicationRecord
  belongs_to :product

  def self.createProductImage(img, product_id)
    product_img = ProductImage.create(name: img[:image_name], product_id: product_id)
    product_img
  end
  
  def self.updateProductImage(img, product_id)
    if img[:id].present?
      product_img = ProductImage.find(img[:id])
      if img[:is_delete] == true
        product_img.delete
      elsif img[:is_change] == true
        product_img.update(name: img[:image_name])
      end
    else
      ProductImage.create(name: img[:image_name], product_id: product_id)
    end
  end
end
