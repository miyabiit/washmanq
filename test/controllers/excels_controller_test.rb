require 'test_helper'

class ExcelsControllerTest < ActionDispatch::IntegrationTest
  test "should get import" do
    get excels_import_url
    assert_response :success
  end

end
