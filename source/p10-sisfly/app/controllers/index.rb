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
  crimeData = []
  path_coordinates.each do |individual_coordinate|
    crimeData << nearby_crimes(individual_coordinate)
  end
  content_type :json
  crimeData.to_json
end
