require 'rubygems'
require 'sinatra'
require 'will_paginate/array'
require "will_paginate-bootstrap"

#Adding this as I'm being a bit lazy
require 'active_support'


#Load application libraries
Dir[File.join(File.dirname(__FILE__), "./lib/**/*.rb")].each do |file|
  require file
end

include MovieFinder
include AlbumFinder
include ActiveSupport::Inflector

helpers do

  def movie(query)
    if !query.empty?
      conf = image_config_settings
      results = movie_search(query)
      @results = removed_nil_images(results).paginate(:page => params[:page], :per_page => 1)
      @image = conf["base_url"] + conf["size"]
      erb :results
    else
      redirect "/"
    end
  end

  def album(query)
    if !query.empty?
      results = album_search(params[:search])
      @results = (results).paginate(:page => params[:page], :per_page => 1)
      erb :album_results
    else
      redirect "/"
    end
  end

  # delete a nil image record:
  def removed_nil_images(results)
    results.delete_if {|x| x["image"] == nil}
  end

  def date_format(date)
    Date.parse(date).strftime("#{ordinalize(Date.parse(date).day)} %B %Y")
  end

end


get "/" do
  erb :index
end

get "/results" do
  query_string = params[:submit_type]
  if query_string == "movie"
    movie(params[:search])
  else
    album(params[:search])
  end
end