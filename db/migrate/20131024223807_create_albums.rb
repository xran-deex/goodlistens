class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :remote_id
      t.string :title
      t.decimal :popularity
      t.integer :year
      t.integer :track_count
      t.references :artist
      t.date :release_date

      t.timestamps
    end
  end
end
