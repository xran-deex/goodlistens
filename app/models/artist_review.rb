class ArtistReview < ActiveRecord::Base
    attr_accessible :review, :artist, :user
    belongs_to :user
    belongs_to :artist
end