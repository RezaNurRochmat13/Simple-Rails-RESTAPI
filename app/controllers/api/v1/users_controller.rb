class Api::V1::UsersController < ApplicationController

	def index
		@users = User.all
		render json: @users
	end

	def request_token
		@users = User.where('email = ? AND password = ?', params[:email], params[:password]).first
		if @users.present?
			render json: {token: @users.tokenid, info: 'Gunakan untuk memanggil api'}
		else	
			render json: {error: 'Users not found'}
		end
	end
end
