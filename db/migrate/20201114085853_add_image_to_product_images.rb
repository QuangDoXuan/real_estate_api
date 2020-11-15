class AddImageToProductImages < ActiveRecord::Migration[5.2]
  def change
    add_column :product_images, :image, :string
  end
end
