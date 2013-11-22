class Rating < ActiveRecord::Base
  attr_accessible :rating
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  validates :rating, :user, :reviewable, presence: true
  validates_uniqueness_of :reviewable_id, :scope => :user_id
end
