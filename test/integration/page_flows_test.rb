require 'test_helper'

class PostFlowsTest < BaseIntegrationTest
  test 'can see pages page' do
    get '/'
    assert_select 'h1', 'Welcome to your new app'
  end
end
