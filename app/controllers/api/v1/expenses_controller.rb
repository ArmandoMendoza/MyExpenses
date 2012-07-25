class Api::V1::ExpensesController < Api::V1::BaseController

	def index
		expenses = current_user.expenses
		respond_with(expenses)
	end

	def create
		expense = Expense.new(params[:expense])
		current_user.expenses << expense
		respond_with(expense)
	end

	def update
		expense = Expense.find(params[:id])
		expense.update_attributes(params[:expense])
		respond_with(expense)
	end
end