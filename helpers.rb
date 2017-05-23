# write to file 
def writer(filename, text)
  File.open(filename, 'w') { |file| file.write(text)}
end


# get the ids (hashes with ids)
def get_ids(api_key)
  puts "start here"
  ids_url = "https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=" + api_key
  response = HTTParty.get(ids_url)
  ids = [13]
  case response.code
    when 200
      response_hash = response.parsed_response
      champions = response_hash["champions"]
      puts champions.class
      champions.each do |champ|
        ids += [champ["id"]]
      end
    when 404
      puts "404 - could not find champion list"
  end
  return ids
end


# write the champ data to a csv
def write_champ_data(filename, data)
  CSV.open(filename, "wb") do |csv|
    csv << ["ID", "Name", "Title"]
    data.each do |data|
      csv << data
    end
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


# for each champ id, get the champ name and title
def collect_data(api_key, ids)
  data = []
  errors = []
  for id in ids
    puts "collecting data for " + id.to_s
    champ_url = "https://na.api.pvp.net/api/lol/static-data/na/v1.2/champion/" + id.to_s
    champ_url += "/?api_key=" + api_key
    response = HTTParty.get(champ_url)
    case response.code
      when 200
        response_hash = response.parsed_response
        name = response_hash["name"]
        title = response_hash["title"]
        data += [[id, name, title]]
      when 404
        puts "error 404"
        errors += [id]
        data += [[id, "no_name", "no_title"]]
    end
  end
  return data
end


# get a valid integer to search
def prompt_id_request()
  print " Please enter a champion ID: "
  id_request = gets.to_i
  while id_request <= 0
    puts "Invalid ID. Please enter a champion ID: "
    id_request = gets.to_i
  end
  return id_request
end
