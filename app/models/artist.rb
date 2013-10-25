class Artist < ActiveRecord::Base
  attr_accessible :image, :name, :popularity, :remote_id, :url
  has_many :reviews, :as => :reviewable 
end
