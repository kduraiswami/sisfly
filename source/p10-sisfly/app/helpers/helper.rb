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
    json_crimes
    hash_crimes = JSON.parse(json_crimes)
    hash_crimes.map!{|crime_args| crime_args.delete_if{|key, value| key == "location"}}
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
    total_sisfly_score = []
    crime_data.each do |individual_crime|
      category_score = sisfly_category(individual_crime)
      total_sisfly_score << (category_score + descript_score)
    end
  end

  private

  def sisfly_category(individual_crime)
    category = individual_crime["category"]
    case category
      when "ARSON"
        100
      "ASSAULT" 90
      "VANDALISM" 80
      "LARCENY/THEFT"
      "OTHER OFFENSES"
      "VEHICLE THEFT"
      "DRUG/NARCOTIC"
      "BURGLARY"
      "NON-CRIMINAL" 50
      "WARRANTS"
      "SUSPICIOUS OCC"
      "FRAUD"
      "SECONDARY CODES"
      "LIQUOR LAWS"
      "MISSING PERSON"
      "SEX OFFENSES, FORCIBLE" 100
      "FORGERY/COUNTERFEITING"
      "SEX OFFENSES, NON FORCIBLE"
      "DRIVING UNDER THE INFLUENCE" 100
      "TRESPASS"
      "GAMBLING" 50
      "STOLEN PROPERTY"
      "KIDNAPPING"
      "RUNAWAY"
      "DRUNKENESS"
      "DISORDERLY CONDUCT"
      "WEAPON LAWS" 80



    end


  end

  def sisfly_descript(individual_crime)

  end



end
