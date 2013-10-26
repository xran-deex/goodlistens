class CreateFriendships < ActiveRecord::Migration
  def up
    create_table :friendships, :id=>false do |t|
        t.integer   :left_user_id
        t.integer   :right_user_id
    end
  end

  def down
    drop_table  :friendships
  end
end
