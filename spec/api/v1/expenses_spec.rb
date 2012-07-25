require 'spec_helper'

describe "Expenses", type: :api do
	before do
		@user = User.make!
		@url = "/api/v1/expenses"
	end

	describe "GET /index" do
		it "should return all expenses of user" do
			3.times { Expense.make!(user: @user) }
			expenses = @user.expenses
			get "#{@url}.json", token: @user.authentication_token
			last_response.body.should eql(expenses.to_json)
			last_response.status.should eql(200)
		end
	end

	describe "POST /create" do
		it "should return a expense create" do
			expense = { description: "A new buy!", amount: 1000, date: Date.today }
			post "#{@url}.json", token: @user.authentication_token, expense: expense
			@user.expenses.last.description.should eq("A new buy!")
			last_response.body.should eq(@user.expenses.last.to_json)
			last_response.status.should eq(201)
		end

		it "should return a error with bad data" do
			expense = { description: "", amount: 1000, date: Date.today }
			post "#{@url}.json", token: @user.authentication_token, expense: expense
			errors = { errors: { description: ["no puede estar en blanco"] } }
			last_response.body.should eq(errors.to_json)
			last_response.status.should eq(422)
		end
	end

	describe "PUT /update" do
		before { @expense = Expense.make!(user: @user, amount: 1400) }
		it "should return a expense updated" do
			new_attributes = { amount: 15000, description: "Buy a car!" }
			put "#{@url}/#{@expense.id}.json", token: @user.authentication_token,
					expense: new_attributes
			last_response.status.should eq(204)
			@user.expenses.last.amount.should eq(15000)
			@user.expenses.last.description.should eq("Buy a car!")
		end

		it "should return a error with bad data" do
			new_attributes = { amount: 15000, description: "" }
			put "#{@url}/#{@expense.id}.json", token: @user.authentication_token,
					expense: new_attributes
			errors = { errors: { description: ["no puede estar en blanco"] } }
			last_response.body.should eq(errors.to_json)
			last_response.status.should eq(422)
		end
	end
end