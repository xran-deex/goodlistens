class TrackReview < ActiveRecord::Base
  attr_accessible :review, :track_id, :user_id
end
