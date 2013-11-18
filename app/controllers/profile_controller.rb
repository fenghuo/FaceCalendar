require 'User_model'
require 'stringio'

class ProfileController < ApplicationController
  def show
	if ! session[:user_id]
		redirect_to :controller => 'login', :action => 'start'
	end
  end

  def ret_data
#	tmp = Tmp.new()
    user = User.Get(session[:user_id])
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
    user = User.Get(session[:user_id])
    user = user.first
    puts "#{user["birthday"].class} \n"
    if tmp = params["birthday"]
        user["birthday"] = Date.parse(tmp)
	params.delete("birthday")
    end

    for key, value in params
      if key == "controller" || key == "action"
        next
      end
      puts "#{key} => #{value} \n"
      user[key] = value
    end
    User.Update(session[:user_id], user["sex"], user["email"], user["picture"], user["firstname"], user["lastname"], user["occupation"], user["skills"], user["birthday"], user["relationship"], user["orientation"], user["introduction"])
  end	

  def uploadPic
=begin
    for key, value in params
      if key == "controller" || key == "action"
	next
      end
      puts "#{key} => #{value} \n"
    end
    puts "#{params["cont"].length} \n"
    some = StringIO.new(params["cont"], "r:binary")
=end
    path = File.join("/home/ubuntu/current/public/profile/pics", params["pro_pic"].original_filename)
    f = File.new(path, "w:ascii-8bit")
    f.write(params["pro_pic"].read)
    f.close
    render 'show'
  end
end
