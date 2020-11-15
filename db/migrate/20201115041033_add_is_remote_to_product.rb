class AddIsRemoteToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_remote, :integer, default: 0
  end
end
