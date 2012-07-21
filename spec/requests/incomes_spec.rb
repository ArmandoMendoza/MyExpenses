require 'spec_helper'

describe "Incomes" do
	before do
		@user = User.make!
		@income = Income.make!(user: @user)
	end

	context "Index" do
		before { login_as @user }
		it "should see all incomes" do
			visit incomes_path
			page.should have_content(@income.description)
		end
	end

	context "Edit" do
		before { login_as @user }

		it "Should edit income" do
			visit edit_income_path(@income)
			fill_in "income_description", with: "New description"
			click_button "Actualizar Ingreso"
			page.should have_content("New description")
			page.should have_content("Ingreso editado.")
		end
	end

	context "New" do
		before { login_as @user }

		it "Should edit income" do
			visit new_income_path(@income)
			fill_in "income_description", with: "Buy a new car!"
			fill_in "income_amount", with: "1000"
			click_button "Crear Ingreso"
			page.should have_content("Buy a new car!")
			page.should have_content("Ingreso agregado.")
		end
	end
end