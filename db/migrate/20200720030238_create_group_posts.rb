class CreateGroupPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :group_posts do |t|
      t.references :group, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
