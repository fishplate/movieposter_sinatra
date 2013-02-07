require 'rubygems'
require 'sinatra'

#Load application libraries
Dir[File.join(File.dirname(__FILE__), "./lib/**/*.rb")].each do |file|
  require file
end

include MovieFinder
include AlbumFinder

get "/" do
  erb :index
end