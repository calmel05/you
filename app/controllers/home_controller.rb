require 'net/sftp'

class HomeController < ApplicationController
  def index
    @file_list = {}

    if params[:dir].nil?
      @directory = "./"
    else
      @directory = params[:dir]
    end

    Net::SFTP.start('fraser.sfu.ca', 'user', :password => 'password') do |sftp|
      sftp.dir.foreach(@directory) do |entry|
        if entry.directory?
          @file_type = 'directory'
        elsif entry.file?
          @file_type = 'file'
        end
        
        @file_list[entry.name] = @file_type
      end
    end
  end
end
