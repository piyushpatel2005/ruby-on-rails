require 'httparty'

class Recipe
  include HTTParty
  ENV["FOOD2FORK_KEY"] = 'api key goes here'

  base_uri "http://food2fork.com/api"
  default_params key: ENV["FOOD2FORK_KEY"]
  format :json

  def self.for (search_word)
    get("/search", query: {q: search_word})["recipes"]
  end
end
