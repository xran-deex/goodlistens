class CreateLocalAlbums < ActiveRecord::Migration
  def change
    create_table :local_albums do |t|
      t.string :title
      t.date :release_date
      t.integer :track_count
      t.integer :year
      t.decimal :popularity
      t.references :local_artist

      t.timestamps
    end
    add_index :local_albums, :local_artist_id
  end
end
