class AddLonLat < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :lon, :string
    add_column :products, :lat, :string

    add_column :projects, :lon, :string
    add_column :projects, :lat, :string
  end
end
