class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :remote_id

      t.timestamps
    end
  end
end
