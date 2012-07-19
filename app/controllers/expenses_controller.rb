class ExpensesController < ApplicationController
  def index
  	@expenses = current_user.expenses
  end

  def new
  	@expense = Expense.new
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
  	@expense = Expense.new(params[:expense])
  	if current_user.expenses << @expense
  		redirect_to expenses_path, notice: "Gasto agregado."
  	else
  		render action: "new"
  	end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(params[:expense])
      redirect_to expenses_path, notice: "Gasto editado."
    else
      render action: "edit"
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path, notice: "Gasto eliminado."
  end
end
