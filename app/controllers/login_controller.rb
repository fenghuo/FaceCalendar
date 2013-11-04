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
	if User.addNew(name, email, password)
	  redirect_to controller: 'calendar', action: 'show'
	else
	end
  end

  def logout
	session[:user_id] = nil
	redirect_to action: 'start'
  end
end
