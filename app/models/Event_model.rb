require 'Conn_model'

class EventDB < ActiveRecord::Base

	def self.Create	(userid,starttime,endtime,erepeat,groupid,eventname,description,place,weekday)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call event_create(#{userid},#{Conn.ESP(starttime)},#{Conn.ESP(endtime)},#{Conn.ESP(erepeat)},#{Conn.ESP(groupid)},#{Conn.ESP(eventname)},#{Conn.ESP(description)},#{Conn.ESP(place)},#{Conn.ESP(weekday)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs
		end	
	end

	def self.GetAll (userid,starttime,endtime)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@rs=client.query("call event_getAll(#{userid},#{Conn.ESP(starttime)},#{Conn.ESP(endtime)})");
			client.close			
			return @rs	
		end
		
	end

	def self.GetPrivate (userid,starttime,endtime)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@rs=client.query("call event_getPrivate(#{userid},#{Conn.ESP(starttime)},#{Conn.ESP(endtime)})");
			client.close			
			return @rs	
		end
		
	end

	def self.GetGroup (userid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@rs=client.query("call event_getGroup(#{userid})");
			client.close			
			return @rs	
		end
		
	end

	def self.GetEvent(eventid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@rs=client.query("call event_getById(#{eventid})");
			client.close			
			return @rs	
		end
	end

	def self.EditTime(eventid,starttime,endtime)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_editTime(#{eventid},#{Conn.ESP(starttime)},#{Conn.ESP(endtime)},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end
		
	def self.EditOthers(eventid,repeat,name,description,place,weekday)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_editOthers(#{eventid},#{Conn.ESP(repeat)},#{Conn.ESP(name)},#{Conn.ESP(description)},#{Conn.ESP(place)},#{weekday},@rs)");
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.Delelte(eventid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_delete(#{eventid},@rs)");#true if succeed
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.AddGroup(eventid, groupid, description)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_addGroup(#{eventid},#{groupid},#{Conn.ESP(description)},@rs)");#true if succeed
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.GetOwner(eventid) #get private userid or groupid
		client= Conn.GetConn
		if(client==nil)
			return -1;
		else		
			@private=client.query("call event_isPrivate(#{eventid})")
			@group=client.query("call event_isGroup(#{eventid})")
			client.close			
			return [@private,@group]
		end
	end

	def self.GetEventGroup(eventid)	#get all groups have this event
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@rs=client.query("call event_getEventGroup(#{eventid})");
			client.close			
			return @rs	
		end
	end

	def self.DelelteFromGroup(eventid,groupid)	#delete an event from group
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_deleteFromGroup(#{eventid},#{groupid},@rs)");#true if succeed
			@rs=client.query("select @rs").first["@rs"];
			client.close			
			return @rs	
		end
	end

	def self.SnapShotUpdate(userid,value)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call snap_event_update(#{userid},#{Conn.ESP(value)})");
			client.close
			return @rs	
		end

	end

	def self.SnapShotGet(userid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			@rs=client.query("call snap_event_get(#{userid})");
			client.close
			return @rs
		end

	end

end
