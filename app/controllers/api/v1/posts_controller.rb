class Api::V1::PostsController < ApplicationController
	before_filter :verify_token
	def index
		@posts = Post.all
        render json: @posts
	end

	def create
		@posts = Post.new(user_id: session[:user_id], description: params[:description], username: params[:username])
		if @posts.save
			render json: @posts
		else
			render json: {error: 'Process failed'}
			
		end
	end

	def update
		@posts = Post.where(id: params[:id], user_id: session[:user_id]).first
		if @posts.update_attribute(:description, params[:description])
			render json: @posts
		else
			render json: {error: 'Process failed'}
		end
	end

	def destroy
		@posts = Post.where(id: params[:id], user_id: session[:user_id]).first
		if @posts.destroy
			render json: {status: 'Successfully'}
		else
			render json: {error: 'Process failed'}
		end
	end
end
