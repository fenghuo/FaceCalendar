require 'Event_model.rb'
require 'Groups_model.rb'

class CalendarController < ApplicationController
  class Event_Test
    attr_accessor :eventname, :weekday, :starttime, :endtime
    def initialize
      @eventname = "group meeting"
      @weekday = 1
      @starttime = DateTime.parse("2013-11-4 10:00:00")
      @endtime   = DateTime.parse("2013-11-4 10:30:00")
    end
  end
  def show
  	if session[:user_id]!=nil
      #Event.GetGroup(1)    #"ucsb cs290 cssa" Getgroup return array
      #@all_group = ["ucsb","cs290","cssa"]
      #<<-DOC
      @all_group = [1,2,4] #Group.FindOnesJoinedGroup(1)
      @all_event = Event.GetAll(1,DateTime.parse("2013-11-4 10:00:00"),DateTime.parse("2013-11-11 10:00:00"))
      #DOC
      #@all_event = [:desp=>"aaaa"] not working!
      #@all_event = Event_Test.new
      #Event.GetAll(1,"2000-01-01 00:00:00","2100-01-01 00:00:00")
      #@new_event = GetNotice(:user_id)  need support
	else 
	  redirect_to :controller => 'login', :action => 'start'
	end
  end
  
  def show_month 
    if session[:user_id]!=nil
      #@all_group = Getgroup(:user_id)    #"ucsb cs290 cssa"
      #@all_event = GetAll(:user_id)
      return
    end
  end
  
  def edit
    if session[:user_id]==0
      return
    end
    
  end
  
  def create_event

  end
end
