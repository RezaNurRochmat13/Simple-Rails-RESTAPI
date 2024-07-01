class Api::V1::UsersController < ApplicationController
	# before_filter :verify_token
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	def index
		@users = User.all
		render json: @users
	end

	def show
		@users = User.find(params[:id])
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
		@users = User.new(username: params[:username], password: params[:password], 
			email: params[:email], phone_no: params[:phone_no],tokenid: session[:tokenid])
		@users.tokenid = SecureRandom.uuid
		if @users.save
			
			render json: @users, status: :created
		else
			render json: {error: 'Process failed'}
			
		end
	end

	def update
		@users = User.where(id: params[:id]).first
		if @users.update_attribute(:username, params[:username])
			render json: @users
		else
			render json: {error: 'Process failed'}
		end
	end

	def destroy
		@users = User.where(id: params[:id]).first
		if @users.destroy
			render json: {status: 'Successfully'}, status: :no_content
		else
			render json: {error: 'Process failed'}
		end
	end

	def set_user
		@user = User.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
		render json: { error: 'User not found' }, status: :not_found
	  end
end
