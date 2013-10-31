require 'User_model.rb'

class SqltestController < ApplicationController
	
	def test
		@value=User.GetTest
		@uid=User.LoginCheck('test','pass')	
	end
end
