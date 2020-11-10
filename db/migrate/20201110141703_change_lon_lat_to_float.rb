class ChangeLonLatToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :lon, :float
    change_column :products, :lat, :float
    change_column :projects, :lon, :float
    change_column :projects, :lon, :float
  end
end
