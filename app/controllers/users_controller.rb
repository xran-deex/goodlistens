require 'sevendigital'
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:newuser]
  @@api_key = 'bc2c15f1d4576dd43e1a8ae69e86fc44'
  @@lastfm = nil
  def index

    session['token'] = nil

    puts current_user.id
    dir = File.dirname(Rails.root.join('public', 'uploads', current_user.id.to_s, 'nothing'))
    
    unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
    end
    @files = Dir.entries(dir).select {|f| !File.directory? f}
    client = Sevendigital::Client.new
    
    top = current_user.ratings.where('rating>4').limit(1)[0]
    if top != nil
      top_album = top.reviewable.remote_id
      top_artist = client.release.get_details(top_album).artist
      @suggestions = client.artist.get_similar(top_artist.id)

      #send email recommendation if last login greater than 5 days.
      if current_user.current_sign_in_at - current_user.last_sign_in_at > 60 * 60 * 24 * 5
        RecommendationMailer.recommend(current_user, @suggestions).deliver
      end
    end
    @activity = []
    @recents = []
    @recommends = current_user.recommendations
    @recommended_albums = []
    @recommends.each do |r|
      puts r.album_id
      @recommended_albums << client.release.get_details(r.album_id)
    end
    @ratings = current_user.ratings.limit(8)
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
    @ratings = @user.ratings.limit(8)
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
    random = Random.new

    # if session[:albumsPage] == nil
    session[:albumsPage] = random.rand(300)
    page = session[:albumsPage]
    puts page
    # end
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
    current_user.friends << User.find(params[:user_id])
  end

  def more_info

  end

  def lastfm_auth
    begin
      if session['token'] == nil
        token = @@lastfm.auth.get_token
        puts 'session is nil'
        @@lastfm.session = @@lastfm.auth.get_session(:token => token)['key']
      else
        @@lastfm.session = @@lastfm.auth.get_session(:token => session['token'])['key']
      end
      current_user.lastfm_key = @@lastfm.session
      current_user.save
      puts 'key updated'
      rescue
        session['token'] = token
        redirect_to 'http://www.last.fm/api/auth/?api_key='+@@api_key+'&token='+token+'&cb=http://localhost:3000/lastfm_auth' and return
      end
      redirect_to action: :chat
  end

  def chat
    api_secret = 'eba6ba8d81fafe2d39a1df4a6d23fefb'
    @@lastfm = Lastfm.new(@@api_key, api_secret)
    if current_user.lastfm_key != nil
    @@lastfm.session = current_user.lastfm_key
    user = @@lastfm.user.get_info
    @@lastfm.radio.tune(:station=>'user/'+user['name']+'/mix')
    playlist = @@lastfm.radio.get_playlist
    @track_list = playlist['trackList']['track']
    @track = playlist['trackList']['track'][0]['location']
  end
    path = Rails.root.join('public', 'uploads', current_user.id.to_s)
    @files = Dir.entries(path).select {|f| !File.directory? f}
    # end
  end

  def update
    current_user.name = params[:user][:name]
    current_user.email = params[:user][:email]
    current_user.save
    redirect_to user_path
  end

  def add_name
    current_user.name = params[:user][:first_name] + ' ' + params[:user][:last_name]
    current_user.save
    redirect_to '/browse'
  end

  def initiate_chat
    WebsocketRails[:initiate].trigger(:chat_request, {id: current_user.id, name: current_user.name, friend_id: params[:friend_id]})
  end
end
