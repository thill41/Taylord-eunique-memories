require 'test_helper'

class AboutFlowsTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @about = create(:about)
  end

  test 'require sign-in' do
    requires_authentication { get edit_about_path }
    requires_authentication { get about_path }
    requires_authentication { patch about_path }
  end

  test 'GET /about signed-in' do
    sign_in @user
    get '/about'

    assert_response :success
  end

  test 'GET /about/edit' do 
    sign_in @user

    get '/about/edit'

    assert_response :success
    assert_select 'h1', 'Edit About'
  end

  test 'PATCH /about success' do
    sign_in @user

    patch '/about', params: { about: { content: 'New content' } }

    assert_redirected_to '/about'
    follow_redirect!
    assert_select "div[role='alert']", success_message(@about)
    assert_select '.trix-content', 'New content'
  end

  test 'PATCH /about failure' do
    sign_in @user

    patch '/about', params: { about: { content: '' } }

    assert_response :success
    assert_select "div[role='alert']", error_message
  end
end
