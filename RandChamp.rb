require 'net/http'
require 'json'
require 'httparty'

puts " ==== start ===="

# write to file 
def writer(filename, text)
  File.open(filename, 'w') { |file| file.write(text)}
end


# read the api key from the other file (not committed lul)
api_key = nil
File.open("api_key.txt").each do |line|
  api_key = line
end


# get the ids
old_ids_url = "https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=" + api_key
ids_url = "https://na1.api.riotgames.com/lol/platform/v3/champions?api_key=" + api_key
response = HTTParty.get(ids_url)
ids = []
case response.code
  when 200
    response_hash = response.parsed_response
    champions = response_hash["champions"]
    puts champions.class
    champions.each do |champ|
      puts champ.to_s
      ids += [champ["id"]]
    end
  when 404
    puts "404 - could not find champion list"
end


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


