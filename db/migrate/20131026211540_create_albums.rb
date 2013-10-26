class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
        t.integer   :remote_id
    end
  end
end
