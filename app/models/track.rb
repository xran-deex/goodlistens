class Track < ActiveRecord::Base
  attr_accessible :remote_id
  has_many :reviews, :as => :reviewable 
  has_many :ratings, :as => :reviewable 
  validates :remote_id, presence: true, uniqueness: true
  validates_uniqueness_of :reviewable_id, :scope => :user_id
end
