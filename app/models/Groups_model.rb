require 'Conn_model.rb'

class Group < ActiveRecord::Base

	def self.SearchByName gname
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call groups_searchByName('#{gname}')");
			client.close			
			return @rs	
		end
	end
	
	def self.create(groupname,category,description)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_create('#{groupname}','#{category}','#{description}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.AddMember(groupid, userid, description)  #add member of group return true/false
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_AddMember(#{groupid},#{userid},'#{description}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.DeleteMember(groupid, userid)#delete a member from group
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_deleteMember(#{groupid},#{userid},@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.FindOnesGroup(userid)   # he creates group
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("select id from groups where userid=#{userid}");
			client.close			
			return @rs	
		end
	end

	def self.FindOnesJoinedGroup(userid) # all groupid
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("select groupid from groupmember where userid=#{userid}");
			client.close			
			return @rs	
		end
	end

	def self.FindGroupMembers(groupid) # memebr of groups
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("select userid from groupmember where groupid=#{groupid})");
			client.close			
			return @rs	
		end
	end
	
	def self.NotifyGroupMember(groupid) ## no db notice

	end
end
