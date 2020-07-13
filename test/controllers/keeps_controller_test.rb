require 'test_helper'

class KeepsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get keeps_create_url
    assert_response :success
  end

  test "should get destroy" do
    get keeps_destroy_url
    assert_response :success
  end

end
