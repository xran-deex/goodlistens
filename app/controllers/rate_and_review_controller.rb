class RateAndReviewController < ApplicationController
  def rate
    rating = Rating.new
    rating.user = current_user
    rating.rating = params[:rating].to_d
    rating.reviewable = Album.find_or_create_by_remote_id(params[:album].to_i)
    rating.save
  end

  def review
    puts params
    @review = Review.new
    @review.user = current_user
    @album = Album.find_or_create_by_remote_id(params[:album])
    @review.reviewable = @album
    @review.review = params[:review]
    @review.save
    @reviews = @album.reviews.order(:created_at => :asc)
    puts @review
    if params[:format] == 'js'
      render :partial => '/album/reviews', :locals => { :r => @review }
    else
      redirect_to album_details_path(:remote_id=>params[:album])
    end
  end
end
