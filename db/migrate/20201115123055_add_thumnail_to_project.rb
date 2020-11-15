class AddThumnailToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :thumnail, :string
    add_column :companies, :thumnail, :string
    add_column :project_images, :image, :string
  end
end
