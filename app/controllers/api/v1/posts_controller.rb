class Api::V1::PostsController < ApplicationController
	# before_filter :verify_token
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	def index
		@posts = Post.all
        render json: @posts
	end

	def show
		@posts = Post.find(params[:id])
		render json: @posts
	end

	def create
		@posts = Post.new(user_id: session[:user_id], description: params[:description])
		if @posts.save
			render json: @posts, status: :created
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
		@posts = Post.where(id: params[:id], username: params[:username], password: params[:password], 
			email: params[:email], phone_no: params[:phone_no]).first
		if @posts.destroy
			render json: {status: 'Successfully'}, status: :no_content
		else
			render json: {error: 'Process failed'}
		end
	end

	def set_post
		@post = Post.find(params[:id])
	  rescue ActiveRecord::RecordNotFound
		render json: { error: 'Post not found' }, status: :not_found
	  end
end
