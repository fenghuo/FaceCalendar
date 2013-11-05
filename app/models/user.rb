require 'Conn_model.rb'
require 'Event_model.rb'
require 'group.rb'

class User < ActiveRecord::Base
	attr :uid, true
	attr :uname, true

	def initialize(userid = 0, username = '')
		uid = userid;
		uname = username;
	end

	# LOGIN & LOGOUT FUNCTION

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

	def signed_in_usr
	end

	# EVENT FUNCTIONS
	
  	def self.GetTest
		client = Conn.GetConn
		@rs = client.query('call event_getAll(1)')	
		client.close
		return @rs
  	end

	# GROUP FUNCTIONS

	def self.quit_group(groupid)
		g = new Group;
  		return g.delete_member(groupid, uid);
	end

  	def self.fetch_group_event(userid, start_time)
  		g = new Group;
  		grs = g.find_ones_own_group(userid);

  		client = Conn.GetConn;
  		events = {};
  		if (client != nil)
	  		grs.each do |groupid|
	  			# should return an array of ids of new group events added between start_time and current_time
	  			evs = client.query("call groupevent_findEvents('#{groupid}', '#{start_time}')");
	  			events[groupid] << evs;
	  		end
	  	end
	  	client.close;
	  	return events;
  	end
  	
  	# return an array of groups that have new updated events
  	def self.find_updated_group(userid)
  		client = Conn.GetConn;
  		notice = false;
  		grs = [];
  		if (client != nil)
  			# CAN WE USE USERID DIRECTLY?
  			notice = client.query("call user_getNotice('#{userid}')");
  			if notice
  				# should return an array of key in groupmembers table
  				# and reset attribute 'notice' of every related record to false
				grs = client.query("call groupmembers_fidndGroupWithNotice('#{userid}')");
			end
		end
		client.close;
		return grs;
  	end

  	# return a hash table {groupid_1 => [groupevent_id_1, groupevent_id_2], ...}
  	def self.find_updated_group_event(userid, last_update_time)
  		client = Conn.GetConn;
  		events = {};
  		if (client != nil)
	  		grs = self.find_group_updated(userid);
	  		grs.each do |groupid|
	  			# should return an array of ids of new group events added between last_update_time and current_time
	  			evs = client.query("call groupevent_findNewEvents('#{groupid}', '#{last_update_time}')");
	  			events[groupid] << evs;
	  		end
	  	end
	  	client.close;
	  	return events;
  	end


end
