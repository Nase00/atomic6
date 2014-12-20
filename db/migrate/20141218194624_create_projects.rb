class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :content
      t.belongs_to :gallery
      t.belongs_to :creator

      t.timestamps
    end
  end
end
