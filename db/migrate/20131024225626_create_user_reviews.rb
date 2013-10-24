class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.references :user
      t.references :reviewable_item

      t.timestamps
    end
    add_index :user_reviews, :user_id
    add_index :user_reviews, :reviewable_item_id
  end
end
