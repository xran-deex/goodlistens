require 'test_helper'

class FbShareControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get client" do
    get :client
    assert_response :success
  end

end
