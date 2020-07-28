require 'test_helper'

class JoinRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get join_rooms_create_url
    assert_response :success
  end

  test "should get destroy" do
    get join_rooms_destroy_url
    assert_response :success
  end

end
