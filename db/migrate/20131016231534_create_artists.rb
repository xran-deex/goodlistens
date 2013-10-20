class CreateArtists < ActiveRecord::Migration
  def up
    create_table :artists do |t|
      t.integer :remote_id
      t.column  :local_artist_id, :integer

      t.timestamps
    end
  end

  def down
    drop_table :artists
  end
end
