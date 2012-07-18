require 'spec_helper'

describe Income do
	before do
		@income = Income.make
	end

	it "should be valid" do
		@income.should be_valid
	end

	it "should be invalid if amount no present" do
		@income.amount = ""
		@income.should_not be_valid
	end

	it "should be invalid if description no present" do
		@income.description = ""
		@income.should_not be_valid
	end

	context "when date no present" do
		it "should assign created_at attribute to date" do
			@income.save
			@income.date.should eq(@income.created_at)
		end
	end

	context "when date present" do
		it "should have the same date" do
			date = Time.now
			@income.date = date
			@income.save
			@income.date.should eq(date)
		end
	end

	context "scopes" do
		before do
			this_month = Date.today
			two_month_ago = Date.today - 60
			@income = Income.make!(date: this_month)
			@income_two = Income.make!(date: two_month_ago)
		end

		it "#at_month without month, return expenses make in current month" do
			Income.at_month.to_a.should eq([@income])
		end

		it "#at_month with month, return expenses make in send month" do
			month = (Date.today - 60).month
			Income.at_month(month).to_a.should eq([@income_two])
		end

		it "#total_at_month, return total amount of expenses, work like #at_month" do
			other_expense = Income.make!(date: Date.today, amount: 100)
			Income.total_at_month.should eq(5100)
		end
	end
end