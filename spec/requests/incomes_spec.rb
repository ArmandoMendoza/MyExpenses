require 'spec_helper'

describe "Incomes", js: true do
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

		it "should edit a incomes" do
			visit edit_income_path(@income)
			fill_in "income_description", with: "buy a car!"
			click_button "Actualizar Ingreso"
			page.should have_content("Buy a car!")
			page.should have_content("Ingreso editado.")
		end
	end

	context "New" do
		before { login_as @user }

		it "should create a income" do
			visit new_income_path
			fill_in "income_description", with: "buy a phone"
			fill_in "income_amount", with: "1000"
			click_button "Crear Ingreso"
			page.should have_content("Buy a phone")
			page.should have_content("Ingreso agregado.")
		end
	end
end