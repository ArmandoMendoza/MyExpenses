require 'spec_helper'

describe "Authentication", type: :api do
	before do
		@user = User.make!
	end

	describe "API errors" do

		it "making a request with no token" do
			get "/api/v1/expenses.json", token: ""
			error = { error: "Llave invalida" }
			last_response.body.should eql(error.to_json)
		end
	end
end