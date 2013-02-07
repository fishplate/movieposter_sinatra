module Movie::MovieFinder

MOVIE_URL = "http://api.themoviedb.org/3/search/movie?api_key="
CONFIG_URL = "http://api.themoviedb.org/3/configuration?api_key="
API_KEY = ((APP_CONFIG) ? APP_CONFIG['api_key'] : nil) || ENV["API_KEY"]

  def movie_search(query)
    query = URI::encode(query)
    response = HTTParty.get(MOVIE_URL + API_KEY + "&query=#{query}", :headers => headers)
    results = JSON.parse(response.body)["results"]
    clean_up(results)
  end

  def image_config_settings
    response = HTTParty.get(CONFIG_URL + API_KEY, :headers => headers)
    results = JSON.parse(response.body)["images"]
    {
      "base_url" => results["base_url"],
      "size" => results["poster_sizes"].last,
    }
  end

private

  def clean_up(results)
    results.map do |r|
      {
        "title" => r["title"], 
        "image" => r["poster_path"],
        "release_date" => r["release_date"]
      }
    end
  end

  def headers
    { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

end