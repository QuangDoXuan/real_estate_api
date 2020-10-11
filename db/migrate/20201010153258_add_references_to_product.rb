class AddReferencesToProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :category, foreign_key: true
    add_reference :products, :project, foreign_key: true
    add_reference :products, :pref, foreign_key: true
  end
end
