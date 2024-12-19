require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get sales_upload_url
    assert_response :success
  end
end
