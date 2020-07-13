require 'test_helper'

class CategoryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get category_new_url
    assert_response :success
  end

end
