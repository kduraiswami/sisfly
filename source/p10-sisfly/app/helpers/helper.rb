require 'open-uri'
require 'json'
require 'pp'

helpers do

  def javascript_env
    @javascript_env ||= {}
  end


  # def relevant_crime(path_coordinates)
  #  path_coordinates.each do |individual_coordinate|
  #     nearby_crimes(individual_coordinate)
  #   end
  # end

  def nearby_crimes(individual_coordinate)
    json_crimes = ""
    open("https://data.sfgov.org/resource/tmnf-yvry.json?$where=within_circle(location,#{individual_coordinate["k"]},#{individual_coordinate["D"]},20)") do |all_crimes|
      all_crimes.each_line {|individual_crime| json_crimes << individual_crime}
    end
    hash_crimes = JSON.parse(json_crimes)
    hash_crimes.map!{|crime_args| crime_args.delete_if{|key, value| key == "location"}}
    hash_crimes
  end

  # hash_crimes.each do |crime_args|
  #   crime = Crime.new(crime_args)
  # end

    # relevant_crime = []

    # weight_crimes(relevant_crime)
  # end

  # def weight_crimes(relevant_crime)

  # end

end
