class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
    def verify_token
        if params[:token].present?
            user = User.where('tokenid = ?', params[:token]).first
            if user.present?
                return session[:user_id] = user.id
            else
                render json: {error: 'Authentication error. Authentication token is not recognized'}
            end
        else
            render json: {error: 'Authentication error. Authentication token is necessary'} 
        end
    end
end
