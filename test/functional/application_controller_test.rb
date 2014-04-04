require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "should get current_user" do
    get :current_user
    assert_response :success
  end

  test "should get check_logined" do
    get :check_logined
    assert_response :success
  end

end
