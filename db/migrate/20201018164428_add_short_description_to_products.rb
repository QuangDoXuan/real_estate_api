class AddShortDescriptionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :short_description, :string, limit: 1000
  end
end
