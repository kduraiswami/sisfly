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
  crimeData = nearby_crimes(relevant_crime(path_coordinates))
  pp @json_crimes
  # pp crimeData
  # path_coordinates.each do |coordinates|
  #   p coordinates
  # end

end
