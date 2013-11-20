class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :reviewable, polymorphic: true
      t.decimal    :rating, :precision => 2, :scale => 1
      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :reviewable_id
  end
end
