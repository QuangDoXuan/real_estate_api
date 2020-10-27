class ChangeDatabase < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :status, :string
    add_column :projects, :release_at, :string
    add_column :projects, :build_status, :string
    add_column :projects, :price_range, :string
    add_column :projects, :project_category_ids, :string

    remove_column :projects, :project_category_id
  end
end
