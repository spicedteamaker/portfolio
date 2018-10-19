require 'test_helper'

class HeaderImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get header_images_new_url
    assert_response :success
  end

  test "should get create" do
    get header_images_create_url
    assert_response :success
  end

end
