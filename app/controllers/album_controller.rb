require 'sevendigital'
class AlbumController < ApplicationController
  def details
    client = Sevendigital::Client.new
    @album = client.release.get_details(params[:remote_id])
    album = Album.find_by_remote_id(@album.id)
    if album != nil
        @reviews = album.reviews.order('created_at DESC')
        @reviews.each do |r|
            if r.user == current_user
                @no_form = true
            end
        end
    end
    @review = Review.new
  end
end