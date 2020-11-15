class ProductImage < ApplicationRecord
  belongs_to :product
  mount_uploader :image, ThumbnailUploader

  def self.createProductImage(img, product_id)
    product_img = ProductImage.create(image: img, product_id: product_id)
    product_img.name = ENV['URL'] + "/uploads/product_image/image/" + product_img.id.to_s + "/" + product_img.image.url.split("/")[-1]
    product_img.save
    product_img
  end
  
  def self.updateProductImage(img, product_id)
    if img[:id].present?
      product_img = ProductImage.find(img[:id])
      if img[:is_delete] == true
        product_img.delete
      elsif img[:is_change] == true
        product_img.update(image: img)
      end
    else
      ProductImage.create(image: img, product_id: product_id)
    end
  end
end
