class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.integer :remote_id
      t.string :name
      t.decimal :popularity
      t.string :image
      t.string :url

      t.timestamps
    end
  end
end
