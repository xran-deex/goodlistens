class CreateTrackReviews < ActiveRecord::Migration
  def change
    create_table :track_reviews do |t|
      t.text :review
      t.integer :track_id
      t.integer :user_id

      t.timestamps
    end
  end
end
