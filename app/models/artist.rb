class Artist < ActiveRecord::Base
    attr_accessible :remote_id
    has_many :artist_reviews
    has_many :users, :through => :artist_reviews
    has_one :local_artist
end