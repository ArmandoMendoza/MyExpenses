class IncomesController < ApplicationController
  def index
  	@incomes = current_user.incomes
  end

  def new
  	@income = Income.new
  end

  def edit
    @income = Income.find(params[:id])
  end

  def create
  	@income = Income.new(params[:income])
  	if current_user.incomes << @income
  		redirect_to incomes_path, notice: "Ingreso agregado."
  	else
  		render action: "new"
  	end
  end

  def update
    @income = Income.find(params[:id])
    if @income.update_attributes(params[:income])
      redirect_to incomes_path, notice: "Ingreso editado."
    else
      render action: "edit"
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    redirect_to incomes_path, notice: "Ingreso eliminado."
  end
end
