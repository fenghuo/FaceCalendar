require 'Conn_model.rb'

class Group < ActiveRecord::Base
	attr :gid, true
	attr :gname, true
	attr :gtype, true

	def initialize(groupid = 0, groupname = '', grouptype = nil)
		gid = groupid;
		gname = groupname;
		gtype = grouptype;
	end

	def self.SearchByName gname
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@grs=client.query("call groups_searchByName('"+gname+"')");
			client.close			
			return @grs.first
		end
	end
	
	def self.create_group(groupname,category,description)
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

	def self.add_member(groupid, userid, current_time, description)
		client = Conn.GetConn;
		found = false;
		added = false;
		if (client != nil)
			found = client.query("call groupmembers_find('#{groupid}', '#{userid}')");
			if !found
				added = client.query("call groupmembers_create('#{groupid}', '#{userid}', '#{current_time}', '#{description}')");
			end
		end
		client.close;
		return added;
	end

	def self.delete_member(groupid, userid)
		client = Conn.GetConn;
		deleted = false;
		if (client != nil)
			deleted = client.query("call groupmembers_delete('#{groupid}', '#{userid}')");
		end
		client.close;
		return deleted;
	end

	def self.find_ones_group(userid)
=begin
		client = Conn.GetConn;
		grs = [];
		if (client != nil)
			# should check the existence first
			# should return an array of group_id 
			grs = client.query("call groupmembers_findOnesGroup('#{userid}')");
		end
		client.close;
=end
		grs = nil;
		grs_user_1 = [
			{groupid: 1, time: '2013-10-23 09:23:00', description: 'I am the administrater.' },
			{groupid: 2, time: '2013-10-25 13:05:00', description: 'I am the administrater.' },
			{groupid: 3, time: '2013-10-27 20:38:00', description: 'I am the administrater.' }
			];
		grs_user_2 = [
			{groupid: 4, time: '2013-10-31 21:56:00', description: 'I am the administrater.' }
			];

		grs = grs_user_1;
		return grs;
	end

	def self.find_ones_joined_group(userid)
=begin
		client = Conn.GetConn;
		grs = [];
		if (client != nil)
			# should check the existence first
			# should return an array of group_id
			grs = client.query("call groupmembers_findJoinedGroup('#{userid}')");
		end
		client.close;
=end
		grs = nil;
		grs_user_1 = [
			{groupid: 1, time: '2013-10-23 09:23:00', description: 'I am the administrater.' },
			{groupid: 2, time: '2013-10-25 13:05:00', description: 'I am the administrater.' },
			{groupid: 3, time: '2013-10-27 20:38:00', description: 'I am the administrater.' },
			{groupid: 4, time: '2013-10-27 22:38:00', description: 'I am a member.' }
			];
		grs_user_2 = [
			{groupid: 3, time: '2013-10-20 15:12:00', description: 'I am a member.' },
			{groupid: 4, time: '2013-10-31 21:56:00', description: 'I am the administrater.' }
			];

		grs = grs_user_1;
		return grs;
	end


	def self.find_group_members(groupname)
		groupid = self.find_group_id(groupname);
		return find_group_members(groupid);
	end

	def self.find_group_members(groupid)
=begin
		client = Conn.GetConn;
		rs = [];
		if (client != nil)
			# should return an array of user_id in group
			rs = client.query("call groupmembers_findMembers('#{groupid}')");
		end
		client.close;
=end
		rs = [ {userid:1}, {userid:2}, {userid:3}, {userid:4}, {userid:5}, {userid:6}, {userid:7}, {userid:8}, {userid:9}, {userid:10}, {userid:11}];
		return rs;
	end

	def self.notify_group_member(groupid)
		client = Conn.GetConn;
		if (client != nil)
			rs = self.find_group_members(groupid);
			rs.each do |userid|
				# should set attribute 'notice' to be true
				client.query("call user_addNotice('#{userid}')");
				# should set attribute 'notice' to be true
				client.query("call groupmembers_addNotice('#{groupid}','#{userid}')");
			end
		end
		client.close;
	end

	def self.find_group_id(groupname)
		client = Conn.GetConn;
		groupid = -1;
		if (client != nil)
			groupid = clinet.query("call groups_findGroupID('#{groupname}')");
		end
		client.close;
		return groupid;
	end

	def self.find_group_name(groupid)
=begin
		client = Conn.GetConn;
		gname = '';
		if (client != nil)
			gname = clinet.query("call groups_findGroupName('#{groupid}')");
		end
		client.close;
=end
		gname = 'group' + groupid.to_s;
		return gname;
	end

end