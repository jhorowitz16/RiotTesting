# write to file 
def writer(filename, text)
  File.open(filename, 'w') { |file| file.write(text)}
end


# get the ids
def get_ids()
  ids_url = "https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=" + api_key
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
  return ids
  end
end


# get the API key from the other not committed file
def get_api_key()
  api_key = nil
  File.open("api_key.txt").each do |line|
    api_key = line
  return api_key
  end
end


