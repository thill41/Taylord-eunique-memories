require 'test_helper'

class ContactFlowsTest < BaseIntegrationTest
  test 'send a contact message' do
    get new_contact_url

    assert_response :success
    assert_select 'header', 'Questions?'

    form_data = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      event_date: Time.zone.today,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      reference: Faker::Lorem.paragraph,
      message: Faker::Lorem.paragraph,
      event_type: 'Wedding'
    }
    post contact_url, params: { contact: form_data }
    
    assert_response :redirect
    follow_redirect!
    assert_flash :success
    assert_equal new_contact_path, path
  end
end
