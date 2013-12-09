class UploadController < ApplicationController
  def index
  end

  def uploadFile
    require 'fileutils'
    puts params
    uploaded_io = params[:file]
    dir = File.dirname(Rails.root.join('public', 'uploads', current_user.id.to_s, uploaded_io.original_filename))
    puts dir
    unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
    end
    File.open(Rails.root.join('public', 'uploads', current_user.id.to_s, uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
    end

    dir = File.dirname(Rails.root.join('public', 'uploads', current_user.id.to_s, 'nothing'))

    @files = Dir.entries(dir).select {|f| !File.directory? f}
    
      render :partial => '/upload/fileList', :locals => { :files => @files }
   
  end

  def delete
    file = params[:file]
    File.delete(Rails.root.join('public', 'uploads', current_user.id.to_s, file))
    render nothing: true
  end
end
