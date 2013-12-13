class RateAndReviewController < ApplicationController
  def rate
    rating = Rating.find_or_initialize_by_reviewable_id(Album.find_or_create_by_remote_id(params[:album].to_i))
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
    @review.title = params[:title]
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
    @review.title = params[:title]
    @review.review = params[:review]
    @review.save
    render @review
  end

  def destroy
    review = Review.find(params[:review_id])
    review.destroy
    render nothing: true
    # @album = Album.find_or_create_by_remote_id(params[:album])
    # @reviews = @album.reviews.order(:created_at => :asc)
    # render :partial => '/album/reviews', :locals => { :r => @review }
  end
end
