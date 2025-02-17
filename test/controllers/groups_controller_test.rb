require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_index_url
    assert_response :success
  end

  test "should get create" do
    get groups_create_url
    assert_response :success
  end

  test "should get show" do
    get groups_show_url
    assert_response :success
  end
end
