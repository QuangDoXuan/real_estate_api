class AddIndexToUidProduct < ActiveRecord::Migration[5.2]
  def change
    add_index :products, :uid
  end
end
