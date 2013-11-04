require 'User_model.rb'
require 'Groups_model.rb'
require 'Event_model.rb'
require 'Test_model.rb'

class SqltestController < ApplicationController
	
	def test 
		@value=User.GetTest
		@uid=User.LoginCheck(params[:username],params[:password])
		@test1=Group.create('UCSB CS','2','For csil')	
		@tablename=Test.GetTableName
		@alltable=Test.GetAllTble
	end
end
