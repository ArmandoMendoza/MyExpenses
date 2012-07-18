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
end