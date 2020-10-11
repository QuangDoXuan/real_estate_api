class CreateProduct < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, limit: 1000
      t.string :short_code
      t.text :description
      t.string :price01
      t.string :remote_thumbnail, limit: 1000
      t.string :thumnail
      t.string :address, limit: 1000
      t.integer :bed_rooms
      t.integer :wc
      t.integer :area
      t.integer :front_area
      t.integer :floors
      
      t.timestamps
    end
  end
end
