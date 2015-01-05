class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.belongs_to :commenter
      t.belongs_to :blog

      t.timestamps
    end
  end
end
