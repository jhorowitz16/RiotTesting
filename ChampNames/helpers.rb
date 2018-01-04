# Helper Functions for "ChampSelect.rb"


# get the API key from the other not committed file
def get_api_key()
  api_key = nil
  File.open("api_key.txt").each do |line|
    api_key = line
  return api_key
  end
end


# select the key from the keys list with mod
def select_key(count, keys)
  return keys[count % keys.length]
end


# generate the (3) keys and return them
def generate_keys()
  bobhi = read_key("key_bobhi345.txt")
  floatlift = read_key("key_FloatLift.txt")
  sirbob = read_key("key_sirbob3.txt")
  api = read_key("key_JustForTheApiLul.txt")
  return [bobhi, floatlift, sirbob, api]
end

def read_key(filename)
  File.open(filename).each do |line|
    return line
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


# generic write to file function
def write_list_to_file(filename, data)
  file = File.open(filename, "w")
  data.each do |d|
    file.write(d.to_s + "\n")
  end
  file.close unless file.nil?
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


def prompt_name_request_looped(data)
  id = -1
  while id < 0
    name = prompt_name_request()
    id = find_name(data, name)
  end
  return id
end


# report whether data contains name, and return the ID
def find_name(data, name)
  found = false
  data.each do |champ|
    if champ[1].downcase == name
      puts ">>> " + champ[1] + ", " + champ[2]
      found = true
      return champ[0].to_i
    end
  end
  if not found
    puts name + " was not found. Please try again!"
  end
  return -1 
end


# using the v3 static data endpoint - write to csv TBD
def write_v3_champ_data(api_key, filename)

  url = "https://na1.api.riotgames.com/lol/static-data/v3/champions"
  url += "/?api_key=" + api_key
  response = HTTParty.get(url)
  case response.code
    when 200
      response_data = response["data"]
      puts response_data.keys
      puts response_data["Annie"]
    when 404
      puts "error 404"
  end
  data = []
  write_champ_data(filename, data)
end


# for the champ ID, get the champ's stats in the form of a hash
# for now grab just AD, AS, hp, armor (all base) as 'attributes'
def get_champ_stats(api_key, id, attributes)
  url = "https://na1.api.riotgames.com/lol/static-data/v3/champions"
  url += "/" + id.to_s + "?api_key=" + api_key + "&champData=stats"
  response = HTTParty.get(url)
  stats = {}
  case response.code
    when 200
      stats = response["stats"]
    when 404
      puts "failed to find stats for the id " + id.to_s
      return {}
  end
  ret_set = []
  attributes.each do |attr|
    ret_set.push(stats[attr])
  end
  puts ret_set
  return ret_set
end


# for the name string, return whether the name is taken
def lookup_name(api_key, name)
  url = "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name"
  url += "/" + name + "?api_key=" + api_key 
  response = HTTParty.get(url)
  case response.code
    when 200
      puts ":) found!: " + name
      return true
    when 500 
      puts "not found: " + name
      return false 
    else
      puts response.code
      puts "bad key: " + api_key
      return nil
  end
end


# get all the pokemon moves by scraping pokemondb.net
def get_pokemon_moves()
  moves = []
  url = "https://pokemondb.net/move/all"
  page = HTTParty.get(url)
  parse_page = Nokogiri::HTML(page)
  parse_page.css('.ent-name').map do |a|
    moves.push(a.text)
  end
  return moves
end


# assume summoner names must be letters and numbers
def get_poss_characters()
  alpha = "abcdefghijklmnopqrstuvwxyz0123456789"
  poss = []
  for i in (0..alpha.length-1)
    poss.push(alpha[i])
  end
  return poss
end

# generate 1 character names
def get_one_char_names()
  names = []
  chars = get_poss_characters
  for pos in 0..chars.length-1
    names.push(chars[pos])
  end
  return names
end


# generate 2 character names
def get_two_char_names()
  names = []
  chars = get_poss_characters
  for i in 5..chars.length-1
    for j in 0..chars.length-1
      names.push(chars[i] + chars[j])
    end
  end
  return names
end


# generate 3 character names
def get_three_char_names()
  names = []
  chars = get_poss_characters
  for i in 0..chars.length-1
    for j in 0..chars.length-1
      for k in 0..chars.length-1
        names.push(chars[i] + chars[j] + chars[k])
      end
    end
  end
  return names
end
