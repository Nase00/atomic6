class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :description
      t.string :content
      t.integer :gallery_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
