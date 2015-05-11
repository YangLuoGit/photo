class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.datetime :published_at

      t.timestamps null: false
    end
    add_index :photos, :user_id
    add_index :photos, :category_id
  end
end
