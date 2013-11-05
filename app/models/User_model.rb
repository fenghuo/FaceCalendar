require 'Conn_model.rb'
require 'Event_model.rb'

class User < ActiveRecord::Base

	def self.Create(username,upass,sex,email,profile,picture,description)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call user_create('#{username}','#{upass}','#{sex}','#{email}','#{profile}','#{picture}','#{description}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @grs	
		end
	end
	
	def self.LoginCheck(username,password)
		client= Conn.GetConn	
		@rs=nil	
		if(client==nil)
			return -1;
		else
			# not safe enough to send passwords and store passwords in database
			client.query("call login_check ('"+username.to_s+"','"+password.to_s+"',@rs)")
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end
	
  	def self.GetTest
		client = Conn.GetConn
		@rs = client.query("call event_getAll(1,'2009-1-1','2022-11-1')")	
		client.close
		return @rs
  	end

  	# def signed_in_usr
  	
end
