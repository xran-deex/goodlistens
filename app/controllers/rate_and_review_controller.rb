class RateAndReviewController < ApplicationController
  def rate
    rating = Rating.new
    rating.user = current_user
    rating.rating = params[:rating].to_i
    rating.reviewable = Album.find_or_create_by_remote_id(params[:album].to_i)
    rating.save
  end

  def review
    @review = Review.new
    @review.user = current_user
    @album = Album.find_or_create_by_remote_id(params[:album])
    @review.reviewable = @album
    @review.review = params[:review]
    @review.save
    @reviews = @album.reviews
    respond_to do |format|
      format.html { redirect_to album_details_path(:remote_id=>params[:album]) }
      format.js 
    end
  end
end
