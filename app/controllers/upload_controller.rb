class UploadController < ApplicationController
  def index
  end

  def uploadFile
    require 'fileutils'
    puts current_user.id.to_s
    uploaded_io = params[:file]
    dir = File.dirname(Rails.root.join('public', 'uploads', current_user.id.to_s, uploaded_io.original_filename))
    puts dir
    unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
    end
    File.open(Rails.root.join('public', 'uploads', current_user.id.to_s, uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
    end
    redirect_to :back
  end
end
