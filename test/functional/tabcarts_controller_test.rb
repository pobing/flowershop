require 'test_helper'

class TabcartsControllerTest < ActionController::TestCase
  test "should get addcart" do
    get :addcart
    assert_response :success
  end

end
