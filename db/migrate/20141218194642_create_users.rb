class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :email, :twitter
      t.string :password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
