get '/' do
  erb :index
end

# get '/cartograph/:route_id' do
#   erb :cartograph
# end

get '/cartograph' do
  #@relavent_crime = crime.relavent_crime.to_json
  crime = Crime.all.limit(20)
  @routing_and_crime_data = {startingStreet: params["starting_street"],
                             endingStreet: params["ending_street"],
                             all_crimes: crime}.to_json
  erb :cartograph
  # erb :walkingroute
end
