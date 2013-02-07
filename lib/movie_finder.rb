require 'httparty'
require 'open-uri'
require 'json'

module MovieFinder

MOVIE_URL = "http://api.themoviedb.org/3/search/movie?api_key="
CONFIG_URL = "http://api.themoviedb.org/3/configuration?api_key="
API_KEY = ENV["API_KEY"] || "nokey"

  def movie_search(query)
    query = URI::encode(query)
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    response = HTTParty.get(MOVIE_URL + API_KEY + "&query=#{query}", :headers => headers)
    results = JSON.parse(response.body)["results"]
    clean_up(results)
  end

  def image_config_settings
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    response = HTTParty.get(CONFIG_URL + API_KEY, :headers => headers)
    results = JSON.parse(response.body)["images"]
    {
      "base_url" => results["base_url"],
      "size" => results["poster_sizes"].last,
    }
  end

private

  def clean_up(results)
    return unless results
    results.map do |r|
      {
        "title" => r["title"], 
        "image" => r["poster_path"],
        "release_date" => r["release_date"]
      }
    end
  end

end