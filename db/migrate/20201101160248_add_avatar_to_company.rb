class AddAvatarToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :image, :string
    add_column :companies, :slug, :string, limit: 1000
  end
end
