require 'net/http'
require 'json'
require 'httparty'

# there are 136 champs

puts " ==== start ===="

def writer(filename, text)
  File.open(filename, 'w') { |file| file.write(text)}
end


# read the api key from the other file (not committed lul)
api_key = nil
File.open("api_key.txt").each do |line|
  api_key = line
end


errors = []

for id in 1..200

  champ_url = "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion/" + id.to_s
  champ_url += "/?api_key=" + api_key
  response = HTTParty.get(champ_url)

  case response.code
    when 200
      response_hash = response.parsed_response
      name = response_hash["name"]
      title = response_hash["title"]
      puts name + ", " + title
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
