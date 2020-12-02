require 'test_helper'

class CollageItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get collage:references" do
    get collage_items_collage:references_url
    assert_response :success
  end

  test "should get prompt" do
    get collage_items_prompt_url
    assert_response :success
  end

end
