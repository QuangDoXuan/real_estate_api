class ChangeColumnAreaProduct < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :area, :string
  end
end
