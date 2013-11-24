require 'User_model'

class LoginController < ApplicationController
  def start
	if session[:user_id] == nil
		respond_to do |format|
			format.html
			format.js
		end
	else
		redirect_to controller: 'calendar', action: 'show'
	end
  end

  def login
	email = params[:email]
	password = params[:password]
	res = User.LoginCheck(email, password)
    if res != -1
		session[:user_id] = res
		cookies["hey"] = res
		redirect_to :controller => 'calendar', :action => 'show'
	else
		redirect_to action: "tryAgain"
	end
  end

  def tryAgain
	@notice = "your email or password was not quite right, want to try again?"
  end

  def signup
	if params[:name] == '' || params[:email] == '' || params[:password] == ''
		redirect_to action: 'start'
		return
	end
    name = params[:name].split(' ', 2)
    email = params[:email]
    password = params[:password]
    sex = ''
    picture = ''
    introduction = ''
    firstname = name[0]
    lastname = name[1]
    res = User.Create(email, password, sex, email, picture, firstname, lastname, '', '', nil, '', '',introduction)
       if res != -1
	  session[:user_id] = res
	  redirect_to controller: 'calendar', action: 'show'
	else
	end
  end

  def logout
	session[:user_id] = nil
	cookies.delete "hey"
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
