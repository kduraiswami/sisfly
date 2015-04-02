require 'open-uri'
require 'json'
require 'pp'

helpers do

  def javascript_env
    @javascript_env ||= {}
  end

  def nearby_crimes(individual_coordinate)
    json_crimes = ""
    open("https://data.sfgov.org/resource/tmnf-yvry.json?$where=within_circle(location,#{individual_coordinate["k"]},#{individual_coordinate["D"]},20)") do |all_crimes|
      all_crimes.each_line do |individual_crime|
        json_crimes << individual_crime
      end
    end
    hash_crimes = JSON.parse(json_crimes)
    hash_crimes.map!{|crime_args| crime_args.delete_if{|key, value| key == "location"}}
    hash_crimes
  end
  def location_selector(crime_data)
    #this will (for now) randomly select a crime from each result array from nearby_crimes
    #this is a destructive method but assigned to a new variable in the controller
    selected_crimes = []
    crime_data.each do |coordinate_crime_array|
      selected_crimes << coordinate_crime_array.sample
    end
    selected_crimes[1..-1]
  end

  def sisfly_score(crime_data)
    #this is a hash with a score based on the crimes parsed and a location for google maps to place a marker

  end



end
