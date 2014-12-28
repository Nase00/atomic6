class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.text :content
      t.belongs_to :author

      t.timestamps
    end
  end
end
