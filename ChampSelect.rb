require 'httparty'
require_relative "helpers"

api_key = get_api_key()
filename = "champs.csv"

# (optionally) build the dataset
ids = get_ids(api_key)
data = collect_data(api_key, ids)
write_champ_data(filename, data)

# (optionally) read the dataset 
# data = read_data(filename)

# ask for a name from the user
name = prompt_name_request()

# iterate thru data trying to find the name
find_name(data, name)
