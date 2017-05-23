require 'httparty'
require_relative "helpers"


# get a valid integer to search
print " Please enter a champion ID: "
id_request = gets.to_i
while id_request <= 0
  puts "Invalid ID. Please enter a champion ID: "
  id_request = gets.to_i
end


ids = [id_request]
api_key = get_api_key()


# for each id, create a file for that champ
# post xayah/rakan there are 136 champs
errors = []
for id in ids
  champ_url = "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion/" + id.to_s
  champ_url += "/?api_key=" + api_key
  response = HTTParty.get(champ_url)
  case response.code
    when 200
      response_hash = response.parsed_response
      name = response_hash["name"]
      title = response_hash["title"]
      puts id.to_s + ": " + name + ", " + title
      filename = "champs/" + name + ".txt"
      writer(filename, title + " >>> " + id.to_s)
    when 404
      puts "error 404"
      errors += [id]
  end
end


# record the ids that didn't get a response
writer("errors.txt", errors.to_s)
puts " ==== end ===="


