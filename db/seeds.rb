require 'open-uri'
require 'pp'
require 'json'

json_crimes = ""

open("https://data.sfgov.org/resource/tmnf-yvry.json") do |all_crimes|
  all_crimes.each_line {|individual_crime| json_crimes << individual_crime}
end

hash_crimes = JSON.parse(json_crimes)

hash_crimes.map!{|crime_args| crime_args.delete_if{|key, value| key == "location"}}
hash_crimes.each do |crime_args|
  crime = Crime.create(crime_args)
end
