require 'Conn_model.rb'
require 'Event_model.rb'

class User < ActiveRecord::Base

	def self.Create(username,password,sex,email,picture,firstname,lastname,occupation,skills,birthday,relationship,orientation,introduction)
	# birthday must be in date format
		client= Conn.GetConn
		@rs=-1
		if(client==nil)
			return -1;
		else
			client.query("call user_create(#{Conn.ESP(username)},#{Conn.ESP(password)},#{Conn.ESP(sex)},#{Conn.ESP(email)},#{Conn.ESP(picture)},#{Conn.ESP(firstname)},#{Conn.ESP(lastname)},#{Conn.ESP(occupation)},#{Conn.ESP(skills)},#{Conn.ESP(birthday)},#{Conn.ESP(relationship)},#{Conn.ESP(orientation)},#{Conn.ESP(introduction)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end
	
	def self.Get(userid)
		client= Conn.GetConn	
		@rs=-1	
		if(client==nil)
			return -1;
		else
			@rs = client.query("call user_get(#{userid})")	
			client.close
			return @rs
		end
  	end

	def self.LoginCheck(username,password)
		client= Conn.GetConn	
		@rs=-1	
		if(client==nil)
			return -1;
		else
			# not safe enough to send passwords and store passwords in database
			client.query("call login_check (#{Conn.ESP(username)},#{Conn.ESP(password)},@rs)")
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end
	
	def self.Update(userid,sex,email,picture,firstname,lastname,occupation,skills,birthday,relationship,orientation,introduction)
	# birthday must be in date format
		client= Conn.GetConn
		@rs=-1
		if(client==nil)
			return -1;
		else		
			client.query("call user_update(#{userid},#{Conn.ESP(sex)},#{Conn.ESP(email)},#{Conn.ESP(picture)},#{Conn.ESP(firstname)},#{Conn.ESP(lastname)},#{Conn.ESP(occupation)},#{Conn.ESP(skills)},#{Conn.ESP(birthday)},#{Conn.ESP(relationship)},#{Conn.ESP(orientation)},#{Conn.ESP(introduction)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end
	
	def self.ChangePassword(userid,oldpassword,newpassword)
		client= Conn.GetConn	
		@rs=-1	
		if(client==nil)
			return -1;
		else
			# not safe enough to send passwords and store passwords in database
			client.query("call user_changePassword (#{userid},#{Conn.ESP(username)},#{Conn.ESP(oldpassword)},#{Conn.ESP(newpassword)},@rs)")
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end
	
  	def self.Search(userfullName)
		client = Conn.GetConn
		@rs = client.query("call user_search(#{Conn.ESP(userfullName)})")	
		client.close
		return @rs
  	end
	
  	def self.GetTest
		client = Conn.GetConn
		@rs = client.query("call event_getAll(1,'2009-1-1','2022-11-1')")	
		client.close
		return @rs
  	end
  	
end
