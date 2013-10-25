class Album < ActiveRecord::Base
  attr_accessible :popularity, :references, :release_date, :remote_id, :title, :track_count, :year
  has_many :reviews, :as => :reviewable
end
