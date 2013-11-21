class Rating < ActiveRecord::Base
  attr_accessible :rating
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
end
