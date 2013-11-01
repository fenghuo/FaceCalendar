require 'Conn_model.rb'

class Group < ActiveRecord::Base

	def self.SearchByName gname
		client= Conn.GetConn
		if(client==nil)
			return -1;
		else
			@grs=client.query("call groups_searchByName('"+gname+"')");
			client.close			
			return @grs	
		end
	end

end
