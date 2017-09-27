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

	def create
		@users = User.new(username: params[:username], password_digest: params[:password_digest], email: params[:email], phone_no: params[:phone_no])
		if @users.save
			@users.tokenid = SecureRandom.uuid
			render json: @users
		else
			render json: {error: 'Process failed'}
			
		end
	end
end
