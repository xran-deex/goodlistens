class RateAndReviewController < ApplicationController
  def rate
    rating = Rating.new
    rating.user = current_user
    rating.rating = params[:rating].to_d
    rating.reviewable = Album.find_or_create_by_remote_id(params[:album].to_i)
    rating.save
  end

  def review
    @review = Review.new
    @review.user = current_user
    @album = Album.find_or_create_by_remote_id(params[:album])
    @review.reviewable = @album
    @review.review = params[:review]
    if !@review.save
      @review = nil
    end

    @reviews = @album.reviews.order(:created_at => :asc)
    if params[:format] == 'js'
      render :partial => '/album/reviews', :locals => { :r => @review }
    else
      redirect_to album_details_path(:remote_id=>params[:album])
    end
  end

  def update
    @review = Review.find(params[:review_id])
    @review.review = params[:review]
    @review.save
    render text: @review.review
  end
end
