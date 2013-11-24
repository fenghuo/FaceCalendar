require 'test_helper'

class CalendarControllerTest < ActionController::TestCase
  test "should get check_change" do
    get :check_change
    assert_response :success
  end

end
