require 'Conn_model.rb'

class Event < ActiveRecord::Base

	def self.Create	(userid,starttime,endtime,erepeat,groupid,eventname,description,place,weekday)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else
			client.query("call event_create(#{userid},'#{starttime}','#{endtime}','#{erepeat}',#{groupid},'#{eventname}','#{description}','#{place}',#{weekday}),@rs");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @grs
		end	
	end

	def self.GetAll (userid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@grs=client.query("call event_getAll('#{userid}')");
			client.close			
			return @grs	
		end
		
	end

	def self.GetPrivate (userid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@grs=client.query("call event_getPrivate('#{userid}')");
			client.close			
			return @grs	
		end
		
	end

	def self.GetGroup (userid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@grs=client.query("call event_getGroup('#{userid}')");
			client.close			
			return @grs	
		end
		
	end

	def self.GetEvent(eventid)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			@grs=client.query("select * from `facecalendar`.`event` where `id`=#{eventid}");
			client.close			
			return @grs	
		end
	end

	def self.EditTime(eventid,starttime,endtime)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_editTime(#{eventid},'#{starttime}','#{endtime}',@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @grs	
		end
	end
		
	def self.EditOthers(eventid,repeat,name,description,place,weekday)
		client= Conn.GetConn
		@rs=nil
		if(client==nil)
			return -1;
		else		
			client.query("call event_editOthers(#{eventid},'#{repeat}','#{name}','#{description}','#{place}',#{weekday},@rs)");
			@rs=client.query('select @rs').first["@rs"];
			client.close			
			return @grs	
		end
	end
end
