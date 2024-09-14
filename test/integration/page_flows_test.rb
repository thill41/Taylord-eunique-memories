require 'test_helper'

class PagFlowsTest < BaseIntegrationTest
  test 'Get /' do
    get '/'
    
    assert_select 'h2', 'Our Mission: Delivering Excellence Every Day'
  end
end
