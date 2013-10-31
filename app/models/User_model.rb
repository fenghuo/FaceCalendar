class User < ActiveRecord::Base
	
	def self.GetConn
		config = YAML::load_file("config/database.yml")["development"]
		client = Mysql2::Client.new(config)
		return client
	end

	def self.LoginCheck(username,password)
		client= User.GetConn		
		if(client==nil)
			return -1;
		else
			client.query("call login_check ('"+username.to_s+"','"+password.to_s+"',@rs)")
			@rs=client.query('select @rs').first["@rs"];
			return @rs	
		end
	end
	
  	def self.GetTest
		client = User.GetConn
		@rs = client.query('call event_getAll(1)')	
		client.close
		return @rs
  	end
end
