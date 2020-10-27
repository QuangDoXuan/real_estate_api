class CreateCompany < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :web_site
      t.string :aniverse
      t.string :field
      t.string :fund
      t.text :description

      t.timestamps
    end
  end
end
