class AddIsPresent < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_present, :integer, default: 0
  end
end
