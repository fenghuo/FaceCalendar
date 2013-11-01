require 'Groups_model.rb'

class SearchController < ApplicationController
  def group
	@grs=nil
	if(params[:gname]!=nil)
		@grs=Group.SearchByName(params[:gname])
	return @grs
		
	end
  end

  def event
  end

  def user
  end
end
