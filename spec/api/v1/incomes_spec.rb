require 'spec_helper'

describe "Incomes", type: :api do
	before do
		@user = User.make!
		@url = "/api/v1/incomes"
	end

	describe "GET /index" do
		it "should return all incomes of user" do
			3.times { Income.make!(user: @user) }
			incomes = @user.incomes
			get "#{@url}.json", token: @user.authentication_token
			last_response.body.should eql(incomes.to_json)
			last_response.status.should eql(200)
		end
	end

	describe "POST /create" do
		it "should return a income create" do
			income = { description: "Win a lottery!", amount: 1000, date: Date.today }
			post "#{@url}.json", token: @user.authentication_token, income: income
			@user.incomes.last.description.should eq("Win a lottery!")
			last_response.body.should eq(@user.incomes.last.to_json)
			last_response.status.should eq(201)
		end

		it "should return a error with bad data" do
			income = { description: "", amount: 1000, date: Date.today }
			post "#{@url}.json", token: @user.authentication_token, income: income
			errors = { errors: { description: ["no puede estar en blanco"] } }
			last_response.body.should eq(errors.to_json)
			last_response.status.should eq(422)
		end
	end

	describe "PUT /update" do
		before { @income = Income.make!(user: @user, amount: 1400) }
		it "should return a income updated" do
			new_attributes = { amount: 15000, description: "Buy a car!" }
			put "#{@url}/#{@income.id}.json", token: @user.authentication_token,
					income: new_attributes
			last_response.status.should eq(204)
			@user.incomes.last.amount.should eq(15000)
			@user.incomes.last.description.should eq("Buy a car!")
		end

		it "should return a error with bad data" do
			new_attributes = { amount: 15000, description: "" }
			put "#{@url}/#{@income.id}.json", token: @user.authentication_token,
					income: new_attributes
			errors = { errors: { description: ["no puede estar en blanco"] } }
			last_response.body.should eq(errors.to_json)
			last_response.status.should eq(422)
		end
	end
end