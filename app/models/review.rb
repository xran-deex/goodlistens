class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  attr_accessible :review, :created_at 
  validates :review, :user, :reviewable, presence: true
  validates_uniqueness_of :reviewable_id, :scope => :user_id
end
