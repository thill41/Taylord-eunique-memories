require 'test_helper'

class PageFlowsTest < BaseIntegrationTest
  setup do
    create(:about)
  end

  test 'GET /' do
    get '/'
    
    assert_select 'h3', 'About'
    assert_select 'a', text: 'Manage Packages', count: 0
    assert_select 'a', text: 'Manage Photo Albums', count: 0

    sign_in create(:user)
    get '/'
    assert_select 'a', text: 'Manage Packages'
    assert_select 'a', text: 'Manage Photo Albums'
  end
end
