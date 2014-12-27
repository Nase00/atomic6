class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :poster
      t.belongs_to :author
      t.belongs_to :blog

      t.timestamps
    end
  end
end
