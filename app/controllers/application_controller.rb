require 'sevendigital'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    user_path
  end

  def search
    client = Sevendigital::Client.new
    @results = client.artist.search(params[:search], :pageSize=>'1')
  end

  def details
    client = Sevendigital::Client.new
    @artist = client.artist.get_details(params[:artist_id])
    @albums = client.artist.get_releases(params[:artist_id], :pageSize=>'24')
  end

  def rate
    puts params[:album]
    review = Review.new
    review.user = current_user
    review.rating = params[:rating].to_i
    review.reviewable = Album.find_or_create_by_remote_id(params[:album].to_i)
    review.save
  end

  #before_filter :authenticate_user!

  # def index
  #   @user = current_user
  # end

  # private
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # helper_method :current_user
end
