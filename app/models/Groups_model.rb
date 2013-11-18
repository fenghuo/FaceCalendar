require 'Conn_model.rb'

class Group < ActiveRecord::Base

	def self.SearchByName gname
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call groups_searchByName(#{Conn.ESP(gname)})");
			client.close			
			return @rs	
		end
	end
	
	def self.Create(groupname,category,description,userid,groupsize,imageurl)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_create(#{Conn.ESP(groupname)},#{Conn.ESP(category)},#{Conn.ESP(description)},#{Conn.ESP(userid)},#{Conn.ESP(groupsize)},#{Conn.ESP(imageurl)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
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
			client.query("call groups_AddMember(#{groupid},#{userid},#{Conn.ESP(description)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
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
			@rs=client.query("select @rs").first["@rs"];
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
			@rs=client.query("call groups_getCreatedById(#{userid})");
			client.close			
			return @rs	
		end
	end

	def self.FindOnesJoinedGroup(userid) # all groupid id only
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call groups_getJoinedById(#{userid})");
			client.close			
			return @rs	
		end
	end

	def self.FindOnesJoinedGroupWithGroupName(userid) # all groupid
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call groups_findGroupWithName(#{userid})");
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
			@rs=client.query("call groups_getMembersById(#{groupid})");
			client.close			
			return @rs	
		end
	end

	def self.GetById(groupid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call groups_getById(#{groupid})");
			client.close			
			return @rs	
		end

	end

	def self.ChangeSize(groupid,size)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_getById(#{groupid},#{size},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close
			return @rs	
		end

	end

	def self.Delete(groupid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call groups_delete(#{groupid},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close
			return @rs	
		end

	end
	
	def self.NotifyGroupMember(groupid) ## no db notice

	end
end
