# goal - find set of summoner names that are currently not taken in NA

require 'httparty'
require 'nokogiri'
require_relative "helpers"

# timer
start = Time.new

# init keys and files
seed = rand(100)
keys = generate_keys()
taken = File.open("names/" + seed.to_s + "_taken.txt", "w")
not_taken = File.open("names/" + seed.to_s + "_nottaken.txt", "w")

# generate names
names = get_three_char_names()
puts names

# check each name, and add to the correct list
taken_names = []
not_taken_names = []
start = Time.new
count = 0
names.each do |name|
  api_key = select_key(count, keys)
  if lookup_name(api_key, name)
    taken_names.push(name)
    taken.write(name + "\n")
  else
    not_taken_names.push(name)
    not_taken.write(name + "\n")
  end
  count += 1
  sleep(4)
end

# calculate and report meta data
finish = Time.new
diff = finish-start
diff_str = "total time difference: " + (finish-start).to_s
avt_str = "average time: " + (diff/names.length).to_s
taken_str = "taken: " + taken_names.length.to_s
not_taken_str = "not_taken: " + not_taken_names.length.to_s
metadata = [diff_str, avt_str, seed.to_s, taken_str, not_taken_str]
metadata.each do |d|
  puts d
end
write_list_to_file("names/meta_data" +seed.to_s + ".txt", metadata)

# close files
taken.close unless taken.nil?
not_taken.close unless not_taken.nil?

