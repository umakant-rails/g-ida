require 'test_helper'

class PollControllerTest < ActionController::TestCase
  test "should get take" do
    get :take
    assert_response :success
  end

end
