#update from master server
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	before_action :session_required	
		
	def session_required
		if session[:user]!=nil
			#redirect_to "/"
		elsif (user_id = cookies.signed[:user_id])
			user=User.find(user_id)
			if user && user.authenticated?(cookies[:remember_token])
				#debugger
				#redirect_to "/"
				#new update
			else 
				redirect_to "/login"
			end
		else 
			redirect_to "/login"
		end
	end
end
