class AddIsHotToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_hot, :integer, default: 0
  end
end
