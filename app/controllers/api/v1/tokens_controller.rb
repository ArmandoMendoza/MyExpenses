class Api::V1::TokensController < Api::V1::BaseController
	skip_before_filter :authenticate_user
	before_filter :check_user

	def create
		password = params[:password]
		if @user.valid_password?(password)
			respond_with(@user.authentication_token, location: "/tokens", status: 200)
		else
			respond_with({error: "Password invalido"}, location: "/")
		end
	end

	private

	def check_user
		@user = User.find_by_email(params[:email])
		unless @user
			respond_with({error: "Usuario no encontrado"}, location: "/", status: 404)
		end
	end
end