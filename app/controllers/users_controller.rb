require 'sevendigital'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    client = Sevendigital::Client.new
    top = current_user.ratings.where('rating>4').limit(1)[0]
    if top != nil
      top_album = top.reviewable.remote_id
      top_artist = client.release.get_details(top_album).artist
      @recommends = client.artist.get_similar(top_artist.id)
    end
    @activity = []
    @recents = []
    @ratings = current_user.ratings.limit(5)
    @ratings.each do |f|
      if f.reviewable != nil
        @recents << client.release.get_details(f.reviewable.remote_id)
      end
    end
    @reviews = current_user.reviews.where('review IS NOT NULL')
    @recent_reviews = []
    @reviews.each do |f|
      if f.reviewable != nil
        @recent_reviews << client.release.get_details(f.reviewable.remote_id)
      end
    end
  end

  def other_user
    @user = User.find(params[:id])
    client = Sevendigital::Client.new
    top = @user.ratings.where('rating>4').limit(1)[0]
    if top != nil
      top_album = top.reviewable.remote_id
      top_artist = client.release.get_details(top_album).artist
      @recommends = client.artist.get_similar(top_artist.id)
    end
    @ratings = @user.ratings.limit(5)
    @recents = []
    @ratings.each do |f|
      if f.reviewable != nil
        @recents << client.release.get_details(f.reviewable.remote_id)
      end
    end
    @reviews = @user.reviews.where('review IS NOT NULL')
    @recent_reviews = []
    @reviews.each do |f|
      if f.reviewable != nil
        @recent_reviews << client.release.get_details(f.reviewable.remote_id)
      end
    end
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

  def add_friend
    puts 'sdjkljsdlkfj'
    current_user.friends << User.find(params[:user_id])
  end

  def more_info

  end

  def add_name
    current_user.name = params[:user][:first_name] + ' ' + params[:user][:last_name]
    current_user.save
    redirect_to new_user_path
  end
end