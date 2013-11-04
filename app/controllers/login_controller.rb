class LoginController < ApplicationController
  def start
	email = params[:email]
	password = params[:password]
	if email == "example@facecalendar.com" && password == "nosecret"
		session[:user_id] = 0
		redirect_to :controller => 'calendar', :action => 'show'
	end
		
  end

  def logout
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
