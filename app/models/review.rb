class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  attr_accessible :review, :created_at 
end
