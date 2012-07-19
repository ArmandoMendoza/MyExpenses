module ControllerMacros

  def login_user
    before(:each) do
      @user = User.make!
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end
  end
end