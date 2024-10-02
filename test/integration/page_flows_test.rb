require 'test_helper'

class PageFlowsTest < BaseIntegrationTest
  setup do
    create(:about)
    @mission_statement = create(:mission_statement)
  end

  test 'GET /' do
    get '/'
    
    assert_select 'h2', 'About'
    assert_select 'a', text: 'Sign In'
    assert_select 'a', text: 'Sign Out', count: 0
    assert_select 'a', text: 'Profile', count: 0
    assert_select 'a', text: 'Manage About', count: 0
    assert_select 'a', text: 'Manage Mission Statement', count: 0
    assert_select 'a', text: 'Manage Packages', count: 0
    assert_select 'a', text: 'Manage Photo Albums', count: 0

    sign_in @mission_statement.user
    get '/'

    assert_select 'a', text: 'Sign In', count: 0
    assert_select 'a', text: 'Sign Out'
    assert_select 'a', text: 'Profile'
    assert_select 'a', text: 'Manage About'
    assert_select 'a', text: 'Manage Mission Statement'
    assert_select 'a', text: 'Manage Packages'
    assert_select 'a', text: 'Manage Photo Albums'
  end
end
