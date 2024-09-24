require 'test_helper'

class PagFlowsTest < BaseIntegrationTest
  test 'GET /' do
    get '/'
    
    assert_select 'h2', 'Our Mission: Delivering Excellence Every Day'
    assert_select 'a', text: 'Manage Packages', count: 0
    assert_select 'a', text: 'Manage Photo Albums', count: 0

    sign_in create(:user)
    get '/'
    assert_select 'a', text: 'Manage Packages'
    assert_select 'a', text: 'Manage Photo Albums'
  end
end
