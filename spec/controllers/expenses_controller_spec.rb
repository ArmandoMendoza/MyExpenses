require 'spec_helper'

describe ExpensesController do
  login_user
  before { @expense = Expense.make! }


  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', id: @expense.id
      response.should be_success
    end
  end

end
