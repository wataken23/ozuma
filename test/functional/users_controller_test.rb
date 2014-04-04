require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get mypage_check" do
    get :mypage_check
    assert_response :success
  end

end
