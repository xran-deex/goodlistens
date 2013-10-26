class CreateLocalArtists < ActiveRecord::Migration
  def change
    create_table :local_artists do |t|
      t.string :name
      t.decimal :popularity
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end
