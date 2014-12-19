class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :content
      t.integer :gallery_id
      # t.belongs_to :gallery

      t.timestamps
    end
  end
end
