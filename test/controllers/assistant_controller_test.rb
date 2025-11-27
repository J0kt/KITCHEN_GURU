require "test_helper"

class AssistantControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get assistant_show_url
    assert_response :success
  end
end
