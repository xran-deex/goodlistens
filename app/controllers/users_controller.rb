require 'sevendigital'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    client = Sevendigital::Client.new
    @recommends = client.artist.get_similar(client.artist.search('Green Day')[0].id)
    #@recommends = []
  end

  def newuser
    client = Sevendigital::Client.new
    @albums = []
    if params[:genre] != nil
        @albums = client.release.get_top_by_tag(params[:genre], :pageSize=>'100')
    end
  end

  def rate
    puts params[:album]
    review = Review.new
    review.user = current_user
    review.rating = params[:rating].to_i
    review.reviewable = Album.find_or_create_by_remote_id(params[:album].to_i)
    review.save
  end

end