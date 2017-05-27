# goal - find set of summoner names that are currently not taken in NA

require 'httparty'
require 'nokogiri'
require_relative "helpers"

# timer
start = Time.new

# scrape the moves from pokemondb
moves = get_pokemon_moves()

# init keys and files
seed = rand(100)
keys = generate_keys()
taken = File.open("names/" + seed.to_s + "_taken.txt", "w")
not_taken = File.open("names/" + seed.to_s + "_nottaken.txt", "w")

# check each move, and add to the correct list
taken_moves, not_taken_moves = [], []
start = Time.new
prev = start
count = 0
mid = Time.new
moves.each do |move|
  api_key = select_key(count, keys)
  move = move.delete " "
  move = move.delete "-"
  if lookup_name(api_key, move)
    taken_moves.push(move)
    taken.write(move + "\n")
  else
    not_taken_moves.push(move)
    not_taken.write(move + "\n")
  end
  count += 1
end

# calculate and report meta data
finish = Time.new
diff = finish-start
diff_str = "total time difference: " + (finish-start).to_s
avt_str = "average time: " + (diff/moves.length).to_s
taken_str = "taken: " + taken_moves.length.to_s
not_taken_str = "not_taken: " + not_taken_moves.length.to_s
metadata = [diff_str, avt_str, seed.to_s, taken_str, not_taken_str]
metadata.each do |d|
  puts d
end
write_list_to_file("names/meta_data" +seed.to_s + ".txt", metadata)

# close files
taken.close unless taken.nil?
not_taken.close unless not_taken.nil?

