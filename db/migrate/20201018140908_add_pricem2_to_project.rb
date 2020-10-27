class AddPricem2ToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :pricem2, :string
  end
end
