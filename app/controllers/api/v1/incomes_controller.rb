class Api::V1::IncomesController < Api::V1::BaseController

	def index
		incomes = current_user.incomes
		respond_with(incomes)
	end

	def create
		income = Income.new(params[:income])
		current_user.incomes << income
		respond_with(income)
	end

	def update
		income = Income.find(params[:id])
		income.update_attributes(params[:income])
		respond_with(income)
	end
end