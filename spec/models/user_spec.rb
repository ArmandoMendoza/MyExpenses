require 'spec_helper'

describe User do
  before do
  	@user = User.make
  end

  it "should be valid" do
  	@user.save
  	@user.should be_valid
  end

  it "should be invalid if email no present" do
  	@user.email = ""
  	@user.should_not be_valid
  end

  it "should be invalid if password no present" do
  	@user.password = ""
  	@user.should_not be_valid
  end

  it "should be invalid if name no present" do
  	@user.name = ""
  	@user.should_not be_valid
  end

  context "instance methods" do
    before do
      @user.save
      @other_user = User.make!
      3.times do
        Expense.make!(amount: 100, user: @user)
        Expense.make!(amount: 200, user: @other_user)
        Income.make!(amount: 50, user: @user)
        Income.make!(amount: 100, user: @other_user)
      end
    end

    it "#total_expenses_at_month should return total expenses of user" do
      @user.total_expenses_at_month.should eq(300)
      @other_user.total_expenses_at_month.should eq(600)
    end

    it "#total_incomes_at_month should return total expenses of user" do
      @user.total_incomes_at_month.should eq(150)
      @other_user.total_incomes_at_month.should eq(300)
    end

    it "#balance should return a balance of user" do
      @user.balance.should eq(-150)
      @other_user.balance.should eq(-300)
    end
  end
end