class CalendarController < ApplicationController
  def show
	if session[:user_id] == 0
		return
	end
	session[:user_id] = nil
	redirect_to :controller => 'login', :action => 'start'
  end
end
