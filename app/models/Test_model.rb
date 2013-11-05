require 'Conn_model.rb'

class Test < ActiveRecord::Base

	def self.GetAllTble
		client= Conn.GetConn
		@alltable=[]
		@tablename=Test.GetTableName
		@tablename.each do |t|
			@alltable<<(client.query("select * from `#{t}`"))
		end
		return @alltable	
	end
	
	def self.GetTableName	
		@tablename=["user","event","groupevent","privateevent","groupmember","groups","admin","log","login"]
		return @tablename
	end
end
		
