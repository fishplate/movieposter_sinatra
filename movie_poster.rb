require 'rubygems'
require 'sinatra'
require 'sinatra/assetpack'
require 'less'

get "/" do
  erb :index
end