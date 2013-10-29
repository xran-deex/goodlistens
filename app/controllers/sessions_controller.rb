class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    puts user.id
    session[:auth] = env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    session[:auth] = nil
    redirect_to root_url
  end
end
