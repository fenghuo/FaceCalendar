require 'Conn_model.rb'

class Test < ActiveRecord::Base

	def self.GetAllTble
		client= Conn.GetConn
		@alltable=[]
		@tablename=Test.GetTableName
		@tablename.each do |t|
			@alltable<<(client.query("select * from #{t}"))
		end
		return @alltable	
	end
	
	def self.GetTableName	
		@tablename=["admin","event","groupevent","groupmember","groups","log","login","privateevent","user",]
		return @tablename
	end
end
		
