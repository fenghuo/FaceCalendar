require 'User_model.rb'
require 'Groups_model.rb'
require 'Event_model.rb'
require 'Test_model.rb'

class SqltestController < ApplicationController
	
	def test 
		@value=User.GetTest
		@uid=User.LoginCheck(params[:username],params[:password])
		#@test1=Event.Create(4,'2013-11-3','2013-11-3','test',5,'eventname','for csil','csil',1)
		#@test2=User.Create("Jon","Jon","M","M@M.M","NO","","")		
		@tablename=Test.GetTableName
		@alltable=Test.GetAllTble
	end
end
