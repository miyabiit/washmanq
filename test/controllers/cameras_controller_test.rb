require 'test_helper'

class CamerasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cameras_index_url
    assert_response :success
  end

end
