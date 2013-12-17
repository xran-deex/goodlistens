class CreateRecommendationTable < ActiveRecord::Migration
  def up
    create_table :recommendations do |t|
        t.string :message
        t.integer :user_id, references: :users
        t.integer :friend_id, references: :users
        t.integer :album_id, references: :album
    end
  end

  def down
    drop_table :recommendations
  end
end
