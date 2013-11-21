require 'sevendigital'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    user_path
  end

  def search
    client = Sevendigital::Client.new
    @artists = client.artist.search(params[:search], :pageSize=>'5')
    @users = User.find_all_by_name(params[:search])
    @albums = client.release.search(params[:search], :pageSize=>'5')
    @tracks = client.track.search(params[:search], :pageSize=>'5')
    if @artists.length == 1
      redirect_to details_path(:artist_id=>@artists[0].id)
    end
  end

  def details
    client = Sevendigital::Client.new
    @artist = client.artist.get_details(params[:artist_id])
    @albums = client.artist.get_releases(params[:artist_id], :pageSize=>'100')
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
