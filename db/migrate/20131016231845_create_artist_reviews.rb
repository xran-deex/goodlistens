class CreateArtistReviews < ActiveRecord::Migration
  def up
    create_table :artist_reviews do |t|
        t.column :artist_id, :integer
        t.column :user_id, :integer
        t.text  :review

        t.timestamps
    end
  end

  def down
    drop_table :artist_reviews
  end
end
