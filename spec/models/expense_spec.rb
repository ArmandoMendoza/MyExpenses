require 'spec_helper'

describe Expense do
	before do
		@expense = Expense.make
	end

	it "should be valid" do
		@expense.should be_valid
	end

	it "should be invalid if amount no present" do
		@expense.amount = ""
		@expense.should_not be_valid
	end

	it "should be invalid if description no present" do
		@expense.description = ""
		@expense.should_not be_valid
	end

	context "when date no present" do
		it "should assign created_at attribute to date" do
			@expense.save
			@expense.date.should eq(@expense.created_at)
		end
	end

	context "when date present" do
		it "should have the same date" do
			date = Time.now
			@expense.date = date
			@expense.save
			@expense.date.should eq(date)
		end
	end

	context "scopes" do
		before do
			this_month = Date.today
			two_month_ago = Date.today - 60
			@expense = Expense.make!(date: this_month)
			@expense_two = Expense.make!(date: two_month_ago)
		end

		it "#at_month without month, return expenses make in current month" do
			Expense.at_month.to_a.should eq([@expense])
		end

		it "#at_month with month, return expenses make in send month" do
			month = (Date.today - 60).month
			Expense.at_month(month).to_a.should eq([@expense_two])
		end

		it "#total_at_month, return total amount of expenses, work like #at_month" do
			other_expense = Expense.make!(date: Date.today, amount: 100)
			Expense.total_at_month.should eq(299.99)
		end
	end
end
