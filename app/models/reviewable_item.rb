class ReviewableItem < ActiveRecord::Base
    belongs_to :reviewable, :polymorphic => true
end