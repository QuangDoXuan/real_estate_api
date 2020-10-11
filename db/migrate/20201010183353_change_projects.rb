class ChangeProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :code, :string
    add_column :projects, :slug, :string
  end
end
