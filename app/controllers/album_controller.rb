require 'sevendigital'
class AlbumController < ApplicationController
  def details
    client = Sevendigital::Client.new
    @album = client.release.get_details(params[:remote_id])
    album = Album.find_by_remote_id(@album.id)
    if album != nil
        @reviews = album.reviews.order('created_at DESC')
    end
    @review = Review.new
  end
end