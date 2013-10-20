class WebServiceController < ApplicationController
  def get_artist
    @result = WebService.find_artist(params[:q])
    @releases = @result['response']['releases']['release']
    @image_urls = []
    @album_titles = []
    @releases.each do |i|
        @image_urls << i['image'][0..-7]+'200.jpg'
        @album_titles << i['title']
    end
  end

  def cache_artist
    @result = WebService.cache_albums

  end
end
