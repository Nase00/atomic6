class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.text :content
      t.integer :author_id

      t.timestamps
    end
  end
end
