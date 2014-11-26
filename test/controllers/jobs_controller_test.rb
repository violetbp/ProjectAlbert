require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  test "should get grade" do
    get :grade
    assert_response :success
  end

end
