require 'sevendigital'
class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    client = Sevendigital::Client.new
    @recommends = client.artist.get_similar(client.artist.search('Green Day')[0].id)
    #@recommends = []
  end

  def newuser
  end

end