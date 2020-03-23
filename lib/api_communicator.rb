require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)

  character = find_character_data(character_name)
  get_film_data(character["films"])

end

def find_character_data (character_name)
  response_string = RestClient.get("http://www.swapi.co/api/people/?search=#{character_name}")
  response_hash = JSON.parse(response_string)
  response_hash["results"][0]
end
find_character_data("R2")

def get_film_data(film_urls)  
  film_hash = []
  film_urls.select do |film|
    res = RestClient.get(film)
    film_hash << JSON.parse(res)
  end
  film_hash
end

def print_movies(films)
  output = []
  sorted = []
  films.each do |film|
    output << [film["release_date"], "#{film["title"].upcase}   directed by #{film["director"]}, released: #{film["release_date"]}"]
  end
  output.sort.each {|out| sorted << out[1]}
  sorted
end


def show_character_movies(character)
  films = get_character_movies_from_api(character)
  puts print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
