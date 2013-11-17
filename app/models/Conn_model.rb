
class Conn < ActiveRecord::Base
	def self.GetConn
		config = YAML::load_file("config/database.yml")["development"]
		client = Mysql2::Client.new(config)
		return client
	end

	def self.ESP(string)
		return ActiveRecord::Base.connection.quote(string) 
	end
end
