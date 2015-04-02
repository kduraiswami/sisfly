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
    hash_crimes
  end

  def location_selector(crime_data)
    selected_crimes = []
    crime_data.each do |coordinate_crime_array|
      selected_crimes << coordinate_crime_array.sample
    end
    selected_crimes[1..-1]
  end

  def sisfly_score(crime_data)
    sisfly_score = []
    sisfly_marker_location = ""
    crime_data.each do |individual_crime|
      category_score = sisfly_category(individual_crime)
      sisfly_score << (category_score)
      sisfly_score.inject{|sum, category_score| sum + category_score} / sisfly_score.size
      #maybe average because that incorporates length in a sense
    end
    #sisfly_score << sisfly_location(crime_data)
    sisfly_score
  end

  private

  # def sisfly_location(crime_data)
  #   crime_data_midpoint = (crime_data.length/2).floor
  #   lattitude = crime_data[crime_data_midpoint]["x"]
  #   longitude = crime_data[crime_data_midpoint]["y"]
  #   lattitude
  #   longitude
  # end

  def sisfly_category(individual_crime)
    category = individual_crime["category"]
    p individual_crime["category"]
    p "--------------------------"
    p "I expect this to be a crime category"
    case category
      when "ARSON"
        100
      when "ASSAULT"
        90
      when "VANDALISM"
        80
      when "LARCENY/THEFT"
        90
      when "OTHER OFFENSES"
        30
      when "VEHICLE THEFT"
        40
      when "DRUG/NARCOTIC"
        60
      when "BURGLARY"
        80
      when "NON-CRIMINAL"
        30
      when "WARRANTS"
        40
      when "SUSPICIOUS OCC"
        30
      when "FRAUD"
        30
      when "SECONDARY CODES"
        60
      when "LIQUOR LAWS"
        50
      when "MISSING PERSON"
        70
      when "SEX OFFENSES, FORCIBLE"
        100
      when "FORGERY/COUNTERFEITING"
        50
      when "SEX OFFENSES, NON FORCIBLE"
        100
      when "DRIVING UNDER THE INFLUENCE"
        100
      when "TRESPASS"
        50
      when "GAMBLING"
        50
      when "STOLEN PROPERTY"
        60
      when "KIDNAPPING"
        90
      when "RUNAWAY"
        50
      when "DRUNKENESS"
        60
      when "DISORDERLY CONDUCT"
        70
      when "WEAPON LAWS"
        100
      else
        20
      end
    end

end
