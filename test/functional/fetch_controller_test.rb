require 'test_helper'

class FetchControllerTest < ActionController::TestCase
  test "should get create_cate" do
    get :create_cate
    assert_response :success
  end

end
