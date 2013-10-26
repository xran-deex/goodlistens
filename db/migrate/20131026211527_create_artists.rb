class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
        t.integer   :remote_id
    end
  end
end
