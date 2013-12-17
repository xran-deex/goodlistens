class RecommendationController < ApplicationController
    def send_recommendation
        friends = params[:friends]
        friends.each do |f|
            r = Recommendation.new
            r.message = params[:message]
            r.user_id = f
            r.album_id = params[:album]
            r.friend_id = params[:user_id]
            r.save
        end
    end
end
