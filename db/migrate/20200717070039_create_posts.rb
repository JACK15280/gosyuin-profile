class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :status, null: false
      t.string :title, null: false
      t.text :content
      t.string :image, null: false
      t.timestamps
    end
  end
end
