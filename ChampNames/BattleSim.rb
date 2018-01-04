require 'httparty'
require_relative "helpers"

api_key = get_api_key()
filename = "champs.csv"

# (optionally) build the dataset
# ids = get_ids(api_key)
# data = collect_data(api_key, ids)
# write_champ_data(filename, data)

# (optionally) read the dataset 
data = read_data(filename)

# ask for the names from the user, and find ids
p1_id = prompt_name_request_looped(data)
p2_id = prompt_name_request_looped(data)
puts p1_id.to_s + " | " + p2_id.to_s

# use riotgames v3 api to get base stats
attributes = ["attackdamage", "attackspeedoffset", "hp", "armor"]
p1_stats = get_champ_stats(api_key, p1_id, attributes)
p2_stats = get_champ_stats(api_key, p2_id, attributes)





