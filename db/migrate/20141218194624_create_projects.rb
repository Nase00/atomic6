class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      # t.belongs_to :creator

      t.string :title, :content
      t.integer :gallery_id
      t.integer :creator_id

      t.timestamps
    end
  end
end
