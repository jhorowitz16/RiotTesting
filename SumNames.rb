# goal - find set of summoner names that are currently not taken in NA

require 'httparty'
require 'nokogiri'
require_relative "helpers"

api_key = get_api_key()
filename = "names.csv"

# scrape the moves from pokemondb
moves = get_pokemon_moves()

# check each move, and add to the correct list
write_list_to_file("test.txt", [1, 2, 3, 4])
taken_moves, not_taken_moves = [], []
moves.each do |move|
  move = move.delete " "
  move = move.delete "-"
  if lookup_name(api_key, move)
    taken_moves.push(move)
  else
    not_taken_moves.push(move)
  end
end

# write to file
write_list_to_file("taken_moves.txt", taken_moves)
write_list_to_file("not_taken_moves.txt", not_taken_moves)
