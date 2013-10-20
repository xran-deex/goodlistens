class AlbumReview < ActiveRecord::Base
  attr_accessible :album_id, :review, :user_id
end
