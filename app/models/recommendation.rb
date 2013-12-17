class Recommendation < ActiveRecord::Base
    attr_accessible :users_id, :album_id, :message
    belongs_to :user
end