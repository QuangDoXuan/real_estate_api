class CreatePostsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name, limit: 1000
      t.text :title
      t.string :short_code
      t.text :description
      t.string :thumnail
      
      t.timestamps
    end
  end
end
