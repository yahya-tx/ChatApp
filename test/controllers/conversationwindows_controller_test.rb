require "test_helper"

class ConversationwindowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get conversationwindows_index_url
    assert_response :success
  end

  test "should get create" do
    get conversationwindows_create_url
    assert_response :success
  end

  test "should get show" do
    get conversationwindows_show_url
    assert_response :success
  end
end
