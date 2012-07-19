require 'spec_helper'

describe IncomesController do
  login_user
  before { @income = Income.make! }

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
      get 'edit', id: @income.id
      response.should be_success
    end
  end

end
