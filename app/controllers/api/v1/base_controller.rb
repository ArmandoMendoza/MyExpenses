class Api::V1::BaseController < ApplicationController
	skip_before_filter :authenticate_user!
	before_filter :authenticate_user
	respond_to :json


	private

	def authenticate_user
		@current_user = User.find_by_authentication_token(params[:token])
		unless current_user
			respond_with({error: "Llave invalida"})
		end
	end

	def current_user
		@current_user
	end
end