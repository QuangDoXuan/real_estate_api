class CreateProjectCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :project_categories do |t|
      t.string :name
    end
  end
end
