require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get group" do
    get :group
    assert_response :success
  end

  test "should get event" do
    get :event
    assert_response :success
  end

  test "should get user" do
    get :user
    assert_response :success
  end

end
