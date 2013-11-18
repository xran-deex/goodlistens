require 'sevendigital'
class AlbumController < ApplicationController
  def details
    client = Sevendigital::Client.new
    @album = client.release.get_details(params[:remote_id])
    album = Album.find_by_remote_id(@album.id)
    if album != nil
        @reviews = album.reviews
    end
    @review = Review.new
  end

  def review
    @review = Review.new
    @review.user = current_user
    @album = Album.find_or_create_by_remote_id(params[:album])
    @review.reviewable = @album
    @review.review = params[:review]
    @review.save
    redirect_to album_details_path(:remote_id=>params[:album])
  end
end