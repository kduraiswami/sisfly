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
    crime_data = JSON.parse(json_crimes)
    crime_data
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
    crime_data.each do |crime_collection|
      crime_collection.each do |individual_crime|
        category_score = sisfly_category(individual_crime["category"])
        sisfly_score << (category_score)
      end
    end
    sisfly_score.inject{|sum, category_score| sum + category_score} / sisfly_score.size
  end

  private

  # def sisfly_location(crime_data)
  #   crime_data_midpoint = (crime_data.length/2).floor
  #   lattitude = crime_data[crime_data_midpoint]["x"]
  #   longitude = crime_data[crime_data_midpoint]["y"]
  #   lattitude
  #   longitude
  # end

  def sisfly_category(category)
    case category
      when "ARSON"
        return 100
      when "ASSAULT"
        return 90
      when "VANDALISM"
        return 80
      when "LARCENY/THEFT"
        return 90
      when "OTHER OFFENSES"
        return 30
      when "VEHICLE THEFT"
        return 40
      when "DRUG/NARCOTIC"
        return 60
      when "BURGLARY"
        return 80
      when "NON-CRIMINAL"
        return 30
      when "WARRANTS"
        return 40
      when "SUSPICIOUS OCC"
        return 30
      when "FRAUD"
        return 30
      when "SECONDARY CODES"
        return 60
      when "LIQUOR LAWS"
        return 50
      when "MISSING PERSON"
        return 70
      when "SEX OFFENSES, FORCIBLE"
        return 100
      when "FORGERY/COUNTERFEITING"
        return 50
      when "SEX OFFENSES, NON FORCIBLE"
        return 100
      when "DRIVING UNDER THE INFLUENCE"
        return 100
      when "TRESPASS"
        return 50
      when "GAMBLING"
        return 50
      when "STOLEN PROPERTY"
        return 60
      when "KIDNAPPING"
        return 90
      when "RUNAWAY"
        return 50
      when "DRUNKENESS"
        return 60
      when "DISORDERLY CONDUCT"
        return 70
      when "WEAPON LAWS"
        return 100
      else
        return 20
      end
    end

end
