require 'test_helper'

class PagesControllerTest < BaseIntegrationTest
  test 'should get home' do
    get root_url
    assert_response :success
  end
end
