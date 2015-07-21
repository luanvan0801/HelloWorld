#user controller
#update from server
#update from me
#update from Pycharm branch | server
class UsersController < ApplicationController
	before_action :session_required, only: [:edit_page, :edit_user]
  def addUser
	user=User.new
	user.name=params[:username]
	user.email=params[:email]
	user.password=params[:password]
	user.password_confirmation=params[:password_confirmation]
	#debugger
	if user.save
		redirect_to '/'
	else 
		@user1=user
		#flash[:notice] = user.errors.full_messages
		render "new"
	end
  end
  def edit_page
	if session[:userid]!=nil
		userid=session[:userid]
	else 
		userid=cookies.signed[:user_id]
	end
	@user_session=User.find(userid)
  end
  
  def edit_user
	
	edit_page
	 if @user_session.update_attributes(:name => params[:username], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
		redirect_to '/'
	else 
		render 'edit_page'
	end
  end
  
  def login
  end
  
  def checkLogin
	user=User.new
	name=params[:username]
	password=params[:password]
	checkbox=params[:remember_me]
	account=User.find_by(name: name)
	#debugger
	if account!=nil && account.authenticate(password)
		session[:user] = account.name
		session[:userid] = account.id
		checkbox=="1" ? remember(account) : forget(account)
		redirect_to "/"
	else 
		render "login"
	end
  end
	
	#logout function
	def logout
		if cookies.signed[:user_id]!=nil
			user=User.find(cookies.signed[:user_id])
			forget(user)
		end
		reset_session
		redirect_to "/login"
	end
	# Remembers a user in a persistent session.
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
	# Forgets a persistent session.
	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
	
end
