require 'Event_model.rb'
require 'Groups_model.rb'

class CalendarController < ApplicationController
  helper_method :prep, :group_name2id, :combine_groups
  class Event
    attr_accessor :eventname,:desp,:place,:starttime,:endtime,:groupname, :weekday, :eventid, :eventsid
    def initialize
      @eventname="event_name"
      @desp="event_desp"
      @place="event_place"
    end
  end
  def prep(starttime,endtime)
    #fake record in reality I will request for every week's record
    #need to read the database in the released version
    @event0=Event.new
    @event0.starttime = DateTime.parse("2013-11-04 10:10:00")
    @event0.endtime = DateTime.parse("2013-11-04 12:00:00")
    @event0.groupname = "1;"
    @event0.weekday = @event0.starttime.wday
    @event0.eventid = 0
    if @event0.weekday==0
      @event0.weekday=7
    end

    @event1=Event.new
    @event1.starttime = DateTime.parse("2013-11-03 10:00:00")
    @event1.endtime = DateTime.parse("2013-11-03 12:00:00")
    @event1.groupname = "2;"
    @event1.weekday = @event1.starttime.wday
    @event1.eventid = 1
    if @event1.weekday==0
      @event1.weekday=7
    end

    @event2=Event.new
    @event2.starttime = DateTime.parse("2013-10-03 10:00:00")
    @event2.endtime = DateTime.parse("2013-10-03 12:00:00")
    @event2.groupname = "3;"
    @event2.weekday = @event2.starttime.wday
    @event2.eventid = 2
    if @event2.weekday==0
      @event2.weekday=7
    end


    group_table=Group.FindOnesJoinedGroupWithGroupName(session[:user_id])
    @all_group=[]
    @all_groupid=[]
    group_table.each do |e|
      @all_groupid.push(e["id"])
      @all_group.push(e["name"])
    end
    #@all_group = [1,2,3] #Group.FindOnesJoinedGroup(1)
    #@all_event = [ @event0, @event1, @event2]

    @all_event=[]



    #session[:test]=0
    event_table=EventDB.GetAll(session[:user_id],starttime,endtime)
    if event_table!=[]

      event_table.each do |e|
        event0=Event.new
        
        event0.eventid = e["id"]
        event0.eventname=e["eventname"]
        event0.desp=e["description"]
        event0.place=e["place"]
        event0.starttime = DateTime.parse(e["starttime"].to_s)
        event0.endtime = DateTime.parse(e["endtime"].to_s)
        event0.weekday = event0.starttime.wday
        if @event0.weekday==0
          @event0.weekday=7
        end


        event0groupid=EventDB.GetEventGroup(event0.eventid)
        if event0groupid==nil
          #event0groupid.push(-1)
          event0groupname="private;"

          #EventDB.Delelte(event0.eventid)
          #event0.eventid=EventDB.Create(session[:user_id],event0.starttime,event0.endtime,"",-1,event0.eventname,event0.desp,event0.place,event0.weekday)

        else

          event0groupname=""
          event0groupid.each do |ee|
            idexist=@all_groupid.index(ee["groupid"])
            
          #  if ee==-1
          #    event0groupname="private;"
          #  end
            if idexist
              event0groupname=event0groupname+@all_group[idexist]+";"
            end
          end
        end
        #session[:test]=event0groupname
        #event0.groupname=event0groupname;
        event0.groupname = event0groupname
        

        @all_event.push(event0)
      end
    end

   
    event_table=EventDB.GetPrivate(session[:user_id],starttime,endtime)
    @test=event_table.count
    if event_table!=[]
        event_table.each do |e|
        event0=Event.new
        @test=-1    
        event0.eventid = e["id"]
        event0.eventname=e["eventname"]
        event0.desp=e["description"]
        event0.place=e["place"]
        event0.starttime = DateTime.parse(e["starttime"].to_s)
        event0.endtime = DateTime.parse(e["endtime"].to_s)
        event0.weekday = event0.starttime.wday
        if @event0.weekday==0
          @event0.weekday=7
        end

          event0groupname="private;"

          #EventDB.Delelte(event0.eventid)
          #event0.eventid=EventDB.Create(session[:user_id],event0.starttime,event0.endtime,"",-1,event0.eventname,event0.desp,event0.place,event0.weekday)
        event0.groupname = event0groupname
        

        @all_event.push(event0)
      end
    end







    use_database=false
    if session[:current_event]==nil
      use_database=true
    else
      @all_event.each do |ae|
        if(!session[:current_event].find{|se| se.eventid==ae.eventid})
          use_database=true
        end
      end

      session[:current_event].each do |ae|
        if(!@all_event.find{|se| se.eventid==ae.eventid})
          use_database=true
        end
      end
    end
    #use_database=true
    if(use_database==true)
      session[:current_event]=[]
      currentsid=0
      @all_event.each do |ae|
        session[:current_event].push(ae)
        session[:current_event][session[:current_event].length-1].eventsid=currentsid
        currentsid=currentsid+1
      end

      currentsid=0


    else
      @all_event=session[:current_event]
    end

    session[:current_group]=@all_group
    session[:current_groupid]=@all_groupid
  end

  def group_name2id(name)
    return session[:current_groupid][session[:current_group].index(name)]
  end

  def combine_groups(events,the_event)
    i=0
    #all_event_tmp=events.clone
    #all_event_tmp.sort! { |a,b| a.eventid<=>b.eventid }
    groupnames=""
    #while i<events.length
    #  if all_event_tmp[i].eventid>the_event.eventid
    #    if all_event_tmp[i].starttime==the_event.starttime &&
    #         all_event_tmp[i].endtime==the_event.endtime &&
    #         all_event_tmp[i].eventname==the_event.eventname &&
    #         all_event_tmp[i].desp==the_event.desp
    #        groupnames=groupnames+all_event_tmp[i].groupname
    #    else
    #      break
    #    end
    #  end
    #  i=i+1
    #end
    events.each do |e|
      if e.starttime==the_event.starttime &&
           e.endtime==the_event.endtime &&
           e.eventname==the_event.eventname &&
           e.desp==the_event.desp
        groupnames=groupnames+e.groupname
      end
    end

    return groupnames
  end

  def show
    #session[:current_event]=[]
    

    #data format regulation
    if params[:week_start_para]
      @week_start_tmp=DateTime.parse(params[:week_start_para])

    else
      @week_start_tmp=DateTime.now
    
    end

    @week_start_tmp=DateTime.new(@week_start_tmp.year,@week_start_tmp.mon,@week_start_tmp.day,0,0,0)
    if @week_start_tmp.wday==0
      @week_start_tmp=@week_start_tmp-6
    else
      @week_start_tmp=@week_start_tmp-@week_start_tmp.wday+1
    end
    session[:week_start]=@week_start_tmp
    @week_next_tmp = @week_start_tmp+7
    @week_last_tmp = @week_start_tmp-7
    @start_tmp=@week_start_tmp #for render template
    prep(@week_start_tmp,@week_next_tmp)
    @all_event=session[:current_event]
  	if session[:user_id]!=nil
      #Event.GetGroup(1)    #"ucsb cs290 cssa" Getgroup return array
      #@all_group = ["ucsb","cs290","cssa"]
      #<<-DOC
      
      #Event.GetAll(user_id,DateTime.parse("2013-11-04 00:00:00"),DateTime.parse("2013-11-11 00:00:00"))
      #DOC
      #@all_event = [:desp=>"aaaa"] not working!
      #@all_event = Event_Test.new
      #Event.GetAll(1,"2000-01-01 00:00:00","2100-01-01 00:00:00")
      #@new_event = GetNotice(:user_id)  need support
  	  return 
	  end
	  session[:user_id] = nil
	  redirect_to :controller => 'login', :action => 'start'
  end
  
  def show_month


    if session[:user_id]!=nil
      
      if params[:month_start]
        @month_start_tmp=DateTime.parse(params[:month_start])

      else
        @month_start_tmp=DateTime.now

      end
      @month_start_tmp=DateTime.new(@month_start_tmp.year,@month_start_tmp.mon,1,0,0,0)
      @month_end_tmp=@month_start_tmp+31
      @month_end_tmp=DateTime.new(@month_end_tmp.year,@month_end_tmp.mon,1,0,0,0)-1
      @start_tmp=@month_start_tmp
      if @month_start_tmp.mon==12
        @month_next_tmp=DateTime.new(@month_start_tmp.year+1,1,1,0,0,0)
      else
        @month_next_tmp=DateTime.new(@month_start_tmp.year,@month_start_tmp.mon+1,1,0,0,0)
      end

      if @month_start_tmp.mon==1
        @month_last_tmp=DateTime.new(@month_start_tmp.year-1,12,1,0,0,0)
      else
        @month_last_tmp=DateTime.new(@month_start_tmp.year,@month_start_tmp.mon-1,1,0,0,0)
      end

      prep(@month_start_tmp,@month_next_tmp)


      #@all_group = Getgroup(:user_id)    #"ucsb cs290 cssa"
      #@all_event = GetAll(:user_id)
      return
    end

    redirect_to :controller => 'login', :action => 'start'
  end
  
  def edit
    @all_event=session[:current_event]#can use session to reduce database read

    id=params[:eventsid]
    
    @event_to_show=@all_event.find{|i| i.eventsid==Integer(id)}
    
    @groupnames=combine_groups(@all_event,@event_to_show)

  end
  
  def create_event

    @new_event_eventname=params[:text_event]
    if @new_event_eventname==""
      @new_event_eventname="(Untitled)"
    end
    @new_event_desp=params[:text_event]
    @new_event_group=params[:group_encoded]#group format "groupA;groupB..."


    new_event_time=params[:time_encoded]
    new_event_time_decode=new_event_time.split(";")
    @new_event_start=Array.new
    @new_event_end=Array.new
    week_start_tmp=session[:week_start]
    
    
    #add
    @create_success=1
    @all_event=session[:current_event]
    if @all_event==[]
	      currentsid=-1
    else
        currentsid=@all_event[@all_event.length-1].eventsid
    end
    new_event_time_decode.each do |d|
      ded=d.split(",")
      @new_event_start.push(week_start_tmp+ded[0].to_i-1+ded[1].to_f/24.0)
      @new_event_end.push(week_start_tmp+ded[0].to_i-1+ded[2].to_f/24.0)
      session_rec = Event.new
      session_rec.eventname=@new_event_eventname
      session_rec.desp=@new_event_desp
      session_rec.groupname=@new_event_group
      session_rec.weekday=ded[0].to_i
      session_rec.place=""
      
      session_rec.eventsid=currentsid+1
      currentsid=currentsid+1

      session_rec.starttime=week_start_tmp+ded[0].to_i-1+ded[1].to_f/24.0
      
      session_rec.endtime=week_start_tmp+ded[0].to_i-1+ded[2].to_f/24.0
      session_rec.eventid=session[:current_event].length
      session_rec.groupname.split(";").each do |e|
        if e=="private"
          gid=-1
        else
          gid=group_name2id(e)
        end
        

        session_rec.eventid=EventDB.Create(session[:user_id],session_rec.starttime,session_rec.endtime,"",gid,session_rec.eventname,session_rec.desp,session_rec.place,session_rec.weekday);

        if session_rec.eventid>0
          @create_success=@create_success
        else
          @create_success=0
        end
      end

      session[:current_event].push(session_rec)
    end


    



    respond_to do |format|
      format.html
      format.js 
    end
  end

  def show_event
    @all_event=session[:current_event]#can use session to reduce database read

    id=params[:eventtoshowid]
    
    @event_to_show=@all_event.find{|i| i.eventsid==Integer(id)}

    @groupnames=combine_groups(@all_event,@event_to_show)
    #event=event_fint_by_id[id]
  end

  def backup

    @all_event=session[:current_event]
  end

  def edit_propose
    @all_event=session[:current_event]
    @eventsid=params[:eventsid]
    idx=session[:current_event].index {|e| e.eventsid==@eventsid.to_i}
    go_back_time=session[:current_event][idx].starttime
    if params[:commit]=="save"
      #database edit method
      #session edit
      
      session[:current_event][idx].eventname=params[:eventname]
      session[:current_event][idx].starttime=DateTime.parse(params[:starttime])
      go_back_time=session[:current_event][idx].starttime
      session[:current_event][idx].endtime=DateTime.parse(params[:endtime])
      session[:current_event][idx].place=params[:place]
      session[:current_event][idx].groupname=params[:groupname]
      session[:current_event][idx].desp=params[:desp]

      event_to_show=session[:current_event][idx]
      EventDB.EditTime(event_to_show.eventid,event_to_show.starttime,event_to_show.endtime)
      EventDB.EditOthers(event_to_show.eventid,"",event_to_show.eventname,event_to_show.desp,event_to_show.place,event_to_show.weekday)

    elsif params[:commit]=="delete"
      
      #database delete method
      #session delete
      #currentsid=0
      #session[:current_event]=[]
      #@all_event.each do |e|
      #  if e.eventsid!=@eventsid.to_i
      #    e.eventsid=currentsid
      #    currentsid=currentsid+1
      #    session[:current_event].push(e)
      #  end
      #end
      EventDB.Delelte(session[:current_event][idx].eventid)
      session[:current_event].delete_if {|e| e.eventsid==@eventsid.to_i}

    end
    
    

    
    redirect_to calendar_show_path(week_start_para: go_back_time)
  end
end
