class AddCompanyToProject < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :company, foreign_key: true
    add_column :projects, :total_area, :string
  end
end
