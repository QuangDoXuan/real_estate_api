class AddParseLinkToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :parse_url, :string, limit: 2000
  end
end
