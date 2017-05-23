# Helper Functions for "ChampSelect.rb"


# get the API key from the other not committed file
def get_api_key()
  api_key = nil
  File.open("api_key.txt").each do |line|
    api_key = line
  return api_key
  end
end


# get the champion ids with a request to the champion endpoint
def get_ids(api_key)
  old_ids_url = "https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=" + api_key
  ids_url = "https://na1.api.riotgames.com/lol/platform/v3/champions?api_key=" + api_key
  response = HTTParty.get(ids_url)
  ids = [13]
  case response.code
    when 200
      response_hash = response.parsed_response
      champions = response_hash["champions"]
      champions.each do |champ|
        ids += [champ["id"]]
      end
    when 404
      puts "404 - could not find champion list"
  end
  return ids
end


# for each champ id, get the champion name and title
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


# write the champ data to a csv for future use
def write_champ_data(filename, data)
  CSV.open(filename, "wb") do |csv|
    csv << ["ID", "Name", "Title"]
    data.each do |data|
      csv << data
    end
  end
end


def read_data(filename)
  data = []
  CSV.foreach(filename) do |row|
    data.push(row)
  end
  return data
end


# get a valid integer to search (early version)
def prompt_id_request()
  print "Please enter a champion ID: "
  id_request = gets.to_i
  while id_request <= 0
    puts "Invalid ID. Please enter a champion ID: "
    id_request = gets.to_i
  end
  return id_request
end

def prompt_name_request()
  print "Please enter a champion name: "
  name = gets.downcase
  name.delete!("\n")
  return name
end


# report whether data contains name
def find_name(data, name)
  found = false
  data.each do |champ|
    if champ[1].downcase == name
      puts ">>> " + champ[1] + ", " + champ[2]
      found = true
    end
  end
  if not found
    puts name + " was not found"
  end
end

