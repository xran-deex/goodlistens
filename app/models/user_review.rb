class UserReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable_item
  # attr_accessible :title, :body
end
