class Artist < ActiveRecord::Base
  attr_accessible :image, :name, :popularity, :remote_id, :url
  has_one :reviewable_item, :as => :reviewable 
end
