class AddUidToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :uid, :integer
    add_column :products, :posted_at, :datetime
    add_column :products, :parsed, :integer
  end
end
