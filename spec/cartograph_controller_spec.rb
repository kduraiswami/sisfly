require 'spec_helper'

describe "cartograph_controller" do

	describe 'Get /cartograph page' do

		it "should return a valid response" do 
			get '/cartograph'
			expect(last_response.status).to eq(200)
		end

		it "should include the map canvas tag" do 
			get '/cartograph'
			expect(last_response.body).to include('id="map-canvas"')
		end

		it "should include a back button on the page" do
			get '/cartograph'
			expect(last_response.body).to include('Back')
		end

	end
end