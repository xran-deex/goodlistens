class AddPrimaryKeyToFriendships < ActiveRecord::Migration
  def change
    drop_table :friendships
    execute 'create table friendships (left_user_id, right_user_id, primary key(left_user_id, right_user_id) );'
  end
end
