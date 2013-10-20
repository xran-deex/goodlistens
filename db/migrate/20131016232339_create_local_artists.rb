class CreateLocalArtists < ActiveRecord::Migration
  def up
    create_table :local_artists do |t|
        t.string :name

        t.timestamps
    end
  end

  def down
    drop_table :local_artists
  end
end
