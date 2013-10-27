# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131027050423) do

  create_table "albums", :force => true do |t|
    t.integer "remote_id"
  end

  create_table "artists", :force => true do |t|
    t.integer "remote_id"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :id => false, :force => true do |t|
    t.integer "left_user_id"
    t.integer "right_user_id"
  end

  create_table "local_albums", :force => true do |t|
    t.string   "title"
    t.date     "release_date"
    t.integer  "track_count"
    t.integer  "year"
    t.decimal  "popularity"
    t.integer  "local_artist_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "local_albums", ["local_artist_id"], :name => "index_local_albums_on_local_artist_id"

  create_table "local_artists", :force => true do |t|
    t.string   "name"
    t.decimal  "popularity"
    t.string   "url"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "local_tracks", :force => true do |t|
    t.string   "title"
    t.integer  "track_num"
    t.string   "url"
    t.integer  "local_album_id"
    t.integer  "local_artist_id"
    t.integer  "duration"
    t.decimal  "popularity"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "local_tracks", ["local_album_id"], :name => "index_local_tracks_on_local_album_id"
  add_index "local_tracks", ["local_artist_id"], :name => "index_local_tracks_on_local_artist_id"

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.text     "review"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "rating"
  end

  add_index "reviews", ["reviewable_id"], :name => "index_reviews_on_reviewable_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tracks", :force => true do |t|
    t.integer "remote_id"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
