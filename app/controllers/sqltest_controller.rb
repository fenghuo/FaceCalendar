require 'mysql'

class SqltestController < ApplicationController
  def test
	@result="Failed!"
	con = Mysql.new('localhost', 'root', 'YOUR PASSWORD', 'facecalendar')
	@rs = con.query('select * from user')
	@value="table_username:\n"
	@rs.each_hash { |h| @value+=h['username']+" "}
	con.close
	@result="Succeed!"
  end
end
