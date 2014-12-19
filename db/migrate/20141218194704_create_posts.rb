class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :author

      t.string :title, :content
      t.integer :poster_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
