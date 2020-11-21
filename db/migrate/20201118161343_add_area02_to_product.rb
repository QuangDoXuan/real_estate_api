class AddArea02ToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :area02, :integer
  end
end
