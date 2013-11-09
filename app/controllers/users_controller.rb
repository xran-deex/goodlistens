require 'sevendigital'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    client = Sevendigital::Client.new
    @recommends = client.artist.get_similar(client.artist.search('Green Day')[0].id)
    @activity = []
  end

  def newuser
    client = Sevendigital::Client.new
    @albums = []
    if !session[:albumsPage]
      page = session[:albumsPage] = 1;
    end
    if params[:genre] != nil
      session[:genre] = params[:genre]
      @genre = session[:genre]
        @albums = client.release.get_top_by_tag(params[:genre], :pageSize=>'12', :page=>page)
    end
  end

  def next_albums
    client = Sevendigital::Client.new
    @albums = []
    page = session[:albumsPage]
    page = page + 1;
    session[:albumsPage] = page;
    if params[:genre] != nil
        @albums = client.release.get_top_by_tag(session[:genre], :pageSize=>'12', :page=>page)
    end
    render :partial => 'more'
  end

  def prev_albums
    client = Sevendigital::Client.new
    @albums = []
    page = session[:albumsPage]
    page = page - 1;
    session[:albumsPage] = page;
    if params[:genre] != nil
        @albums = client.release.get_top_by_tag(session[:genre], :pageSize=>'12', :page=>page)
    end
    render :partial => 'more'
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