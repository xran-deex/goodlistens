class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
        t.integer   :remote_id
    end
  end
end
