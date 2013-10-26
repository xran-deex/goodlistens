class CreateLocalTracks < ActiveRecord::Migration
  def change
    create_table :local_tracks do |t|
      t.string :title
      t.integer :track_num
      t.string :url
      t.references :local_album
      t.references :local_artist
      t.integer :duration
      t.decimal :popularity

      t.timestamps
    end
    add_index :local_tracks, :local_album_id
    add_index :local_tracks, :local_artist_id
  end
end
