class LocalAlbum < ActiveRecord::Base
  belongs_to :local_artist
  attr_accessible :popularity, :release_date, :title, :track_count, :year
  has_many :reviews, :as => :reviewable 
end
