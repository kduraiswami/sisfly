require 'spec_helper'

describe "index_controller" do

	describe 'Get/ Index page' do

		it "should return a valid response" do
			get '/'
			expect(last_response.status).to be(200)
		end

		it "should render a form for a starting address" do 
			get '/'
			expect(last_response.body).to include("starting_street")
		end

		it "should render the Sisfly styled logo text" do
			get '/'
			expect(last_response.body).to include("logo")
		end

		it "should render the Sisfly styled tagline text" do
			get '/'
			expect(last_response.body).to include("tagline")
		end

		it "should render a form for an ending address" do 
			get '/'
			expect(last_response.body).to include("ending_street")
		end

		it "should render a button to submit for direction" do 
			get '/'
			expect(last_response.body).to include("submit")
		end

		it "should post submit button to /cartograph route" do 
			get '/'
			expect(last_response.body).to include('action = "/cartograph"')
		end

	end

end