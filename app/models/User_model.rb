require 'Conn_model.rb'
require 'Event_model.rb'

class User < ActiveRecord::Base

	def self.Create(username,password,sex,email,picture,firstname,lastname,occupation,skills,birthday,relationship,orientation,introduction)
	# birthday must be in 'date' format
		client= Conn.GetConn
		@rs=-1
		if(client==nil)
			return -1;
		else		
			client.query("call user_create('#{username}','#{password}','#{sex}','#{email}','#{picture}','#{firstname}','#{lastname}','#{occupation}','#{skills}','#{birthday}','#{relationship}','#{orientation}','#{introduction}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
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
			client.query("call login_check ('#{username}','#{password}',@rs)")
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end
	
	def self.Update(userid,sex,email,picture,firstname,lastname,occupation,skills,birthday,relationship,orientation,introduction)
	# birthday must be in 'date' format
		client= Conn.GetConn
		@rs=-1
		if(client==nil)
			return -1;
		else		
			client.query("call user_update(#{userid},'#{sex}','#{email}','#{picture}','#{firstname}','#{lastname}','#{occupation}','#{skills}','#{birthday}','#{relationship}','#{orientation}','#{introduction}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
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
			client.query("call user_changePassword (#{userid},'#{username}','#{oldpassword}','#{newpassword}',@rs)")
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end
	
  	def self.Search(userid,userfullName)
		client = Conn.GetConn
		@rs = client.query("call user_search(#{userid},'#{userfullName}')")	
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
