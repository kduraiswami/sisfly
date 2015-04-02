require 'json'
require 'pp'
require 'pry'

get '/' do
  erb :index
end

# get '/cartograph/:route_id' do
#   erb :cartograph
# end

get '/cartograph' do
  #@relavent_crime = crime.relavent_crime.to_json
  #directions(params)
  javascript_env['routingData'] = {
    startingStreet: params["starting_street"],
    endingStreet: params["ending_street"],
  }
  erb :cartograph
end

post '/calculation' do
  path_coordinates = JSON.parse(params["path_coordinates"])
  crime_data = []
  path_coordinates.each do |individual_coordinate|
    crime_data << nearby_crimes(individual_coordinate)
  end
  sisflyScore = 10 #sisfly_score(crime_data)
  selectedCrimeLocations = location_selector(crime_data)
  content_type :json
  {crimeData: selectedCrimeLocations, sisflyScore: sisflyScore}.to_json
end
