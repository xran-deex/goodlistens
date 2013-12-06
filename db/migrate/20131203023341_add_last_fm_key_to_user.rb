class AddLastFmKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :lastfm_key, :string
  end
end
