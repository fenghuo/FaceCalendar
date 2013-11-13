require 'User_model'

class ProfileController < ApplicationController
  def show
	if ! session[:user_id]
		redirect_to :controller => 'login', :action => 'start'
	end
  end

  def ret_data
#	tmp = Tmp.new()
    user = User.Get(8)
	respond_to do |format|
	  format.html
      format.json { render :json => user }
	end
  end

  def recv_data
    username = "user1@m.m"
    password = "user1"
    sex = "Male"
    email = "user1@m.m"
    relationship = "Single"
    occupation = "Software Development Engineer"
    skills = "C++, JAVA, Python, javascript, UML"
    tagline = "Geek"
    description = "Test description"

    User.Create(username, password, sex, email, "", "Jack", "Smith", occupation, skills, Date.current(), relationship, "", description)
  end

  def update_info
    for key, value in params
      if key == "controller" || key == "action"
        next
      end
      puts "#{key} => #{value} \n"
    end
  end	
end
