class Artist < ActiveRecord::Base
  attr_accessible :remote_id
  has_many :reviews, :as => :reviewable 
  has_many :ratings, :as => :reviewable 
  validates :remote_id, presence: true, uniqueness: true
end
