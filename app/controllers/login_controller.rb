require 'User_model'

class LoginController < ApplicationController
  def start
	respond_to do |format|
		format.html
		format.js
	end
  end

  def login
	email = params[:email]
	password = params[:password]
	if session[:user_id] = User.LoginCheck(email, password)
		redirect_to :controller => 'calendar', :action => 'show'		
	else
		redirect_to action: "tryAgain"
	end
  end

  def tryAgain
	@notice = "your email or password was not quite right, want to try again?"
  end

  def signup
    name = params[:name]
    email = params[:email]
    password = params[:password]
    sex = ''
    profile = ''
    picture = ''
    description = ''
	if User.Create(email, password, sex, username, profile, picture, description)
	  redirect_to controller: 'calendar', action: 'show'
	else
	end
  end

  def logout
	session[:user_id] = nil
	redirect_to action: 'start'
  end

  # def signup
  # end
  # 1) If a user clicked the singing-up button twice, the database could not find conflict
  # and would add two same email address records. We should generate an index of email 
  # address to avoid conflict between them.
  # 2) use lower case letters in email address
  # def create
  # 	uid = User.LoginCheck(params[:session][:email].downcase,params[:session][:password]);
  # 	if uid
  # 		redirect_to :controller => 'calendar', :action => 'show'
  # 	else
  # 		# error
  # 	end
  # end
end
