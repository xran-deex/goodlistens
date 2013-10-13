require 'test_helper'

class WebServiceControllerTest < ActionController::TestCase
  test "should get get_artist" do
    get :get_artist
    assert_response :success
  end

end
