class CreateReviewableItems < ActiveRecord::Migration
  def up
    create_table :reviewable_items do |t|
        t.references    :reviewable, polymorphic: true
        t.timestamps
    end
  end

  def down
    drop_table :reviewable_items
  end
end
