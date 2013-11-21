class Album < ActiveRecord::Base
  attr_accessible :remote_id
  has_many :reviews, :as => :reviewable 
  has_many :ratings, :as => :reviewable 
end
