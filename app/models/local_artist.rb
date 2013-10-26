class LocalArtist < ActiveRecord::Base
  attr_accessible :image, :name, :popularity, :url
  has_many :reviews, :as => :reviewable 
end
