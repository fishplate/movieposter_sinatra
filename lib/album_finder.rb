require 'httparty'
require 'open-uri'
require 'json'

module AlbumFinder
ALBUM_URL = "https://itunes.apple.com/search?term="

  def album_search(query)
    query = URI::encode(query)
    headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    response = HTTParty.get(ALBUM_URL + "#{query}" + "&entity=album", :headers => headers)
    results = JSON.parse(response.body)["results"]
  end

end