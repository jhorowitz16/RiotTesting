require 'httparty'
require_relative "helpers"

api_key = get_api_key()
ids = get_ids(api_key)
data = collect_data(api_key, ids)
write_champ_data("champs.csv", data)
