require 'test_helper'

class ContactsControllerTest < BaseIntegrationTest
  test 'should get contact form' do
    get new_contact_url
    assert_response :success
  end
end
