require 'test_helper'

class ModelControllerTest < ActionDispatch::IntegrationTest
  test "should get session" do
    get model_session_url
    assert_response :success
  end

end
