class Album < ActiveRecord::Base
  attr_accessible :popularity, :references, :release_date, :remote_id, :title, :track_count, :year
  has_one :reviewable_item, :as => :reviewable
end
