require 'spec_helper'

describe "Tokens", type: :api do
	before do
		@user = User.make!
		@url = "/api/v1/tokens"
	end

	describe "POST /create" do

		context "with valid data" do
			it "should return the authentication token of user" do
				token = @user.authentication_token
				post "#{@url}.json", email: @user.email, password: @user.password
				last_response.body.to_json.should eql(token.to_json)
				last_response.status.should eql(200)
			end
		end

		context "with invalid email" do
			it "should return user no found message" do
				post "#{@url}.json", email: "fake@gmail.com", password: ""
				error = {error: "Usuario no encontrado"}
				last_response.body.should eql(error.to_json)
			end
		end

		context "with invalid password" do
			it "should return invalid password message" do
				post "#{@url}.json", email: @user.email, password: "213"
				error = {error: "Password invalido"}
				last_response.body.should eql(error.to_json)
			end
		end
	end
end