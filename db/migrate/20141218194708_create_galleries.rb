class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      # t.belongs_to :user, foreign_key:

      t.string :title
      t.string :description
      t.string :content
      t.integer :creator_id

      t.timestamps
    end
  end
end
