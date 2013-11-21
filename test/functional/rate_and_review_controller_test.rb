require 'test_helper'

class RateAndReviewControllerTest < ActionController::TestCase
  test "should get rate" do
    get :rate
    assert_response :success
  end

  test "should get review" do
    get :review
    assert_response :success
  end

end
