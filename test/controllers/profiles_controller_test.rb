require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get profiles_edit_url
    assert_response :success
  end
end
