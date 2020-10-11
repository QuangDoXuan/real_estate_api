class CreateProject < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :address
      t.integer :area
      t.integer :building_density
      t.text :place
      t.text :infras
      t.string :scale

      t.timestamps
    end
  end
end
