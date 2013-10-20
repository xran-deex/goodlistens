class CreateAlbumReviews < ActiveRecord::Migration
  def change
    create_table :album_reviews do |t|
      t.text :review
      t.integer :album_id
      t.integer :user_id

      t.timestamps
    end
  end
end
