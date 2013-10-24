class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :remote_id
      t.string :title
      t.decimal :popularity
      t.integer :duration
      t.string :url
      t.integer :track_num
      t.references :artist
      t.references :album

      t.timestamps
    end
  end
end
