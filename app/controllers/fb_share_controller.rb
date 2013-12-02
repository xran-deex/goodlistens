class FbShareController < ApplicationController
  def auth
    fb_post = { :title => params[:title], :url => params[:url], :desc => params[:desc]}
    session['fb_post'] = fb_post
 
    @client = client
 
    redirect_to @client.authorization_uri(
      :scope => [ :offline_access , :publish_stream]
    )
  end

  def callback
    @client = client
    @client.authorization_code = params[:code]
 
    access_token = @client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
 
    me = FbGraph::User.me(access_token)
 
    title = session["fb_post"][:title]
    url = session["fb_post"][:url]
    desc  = session["fb_post"][:desc]
 
    me.feed!(
 
        :message =>  title ,
        :picture => '',
        :link => url,
        :name => title,
        :description => desc
    )
 
    redirect_to root_path
  end

  private

  def client
    api_keys = YAML::load_file("#{Rails.root}/config/api_keys.yml")#[Rails.env]
    key = api_keys['defaults']['facebook']['api_key']
    secret = api_keys['defaults']['facebook']['api_secret']
    fb_auth = FbGraph::Auth.new(key, secret)
    client = fb_auth.client
    client.redirect_uri = "http://localhost:3000/fb_share/callback"
 
    client
  end
end
