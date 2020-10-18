class AddProjectSlug < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :slug_url, :string, limit: 4000
  end
end
