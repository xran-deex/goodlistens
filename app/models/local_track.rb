class LocalTrack < ActiveRecord::Base
  belongs_to :local_album
  belongs_to :local_artist
  attr_accessible :duration, :popularity, :title, :track_num, :url
  has_many :reviews, :as => :reviewable 
end
