require 'sevendigital'
class TrackController < ApplicationController
  def trackdetails
    client = Sevendigital::Client.new
    @track = client.release.get_details(params[:remote_id])
    track = Track.find_by_remote_id(@track.id)
    if track != nil
        @reviews = track.reviews
    end
    @review = Review.new
  end

  def trackreview
    @review = Review.new
    @review.user = current_user
    track = Track.find_or_create_by_remote_id(params[:track])
    @review.reviewable = track
    @review.review = params[:review]
    @review.save
    redirect_to track_trackdetails_path(:remote_id=>params[:track])
  end
end