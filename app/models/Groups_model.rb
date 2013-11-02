require 'Conn_model.rb'

class Group < ActiveRecord::Base

	def self.SearchByName gname
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@grs=client.query("call groups_searchByName('"+gname+"')");
			client.close			
			return @grs	
		end
	end
	
	def self.create(groupname,category,description)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_create('#{gname}','#{category}','#{description}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @grs	
		end
	end
end
