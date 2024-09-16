require 'test_helper'

class AboutsControllerTest < BaseIntegrationTest
  def setup
    @user = create(:user)
    @about = create(:about)
  end

  test 'GET show' do
    get about_url

    assert_response :success
  end

  test 'GET edit' do
    sign_in @user

    get edit_about_url

    assert_response :success
  end

  test 'PATCH update success' do
    sign_in @user

    patch about_url, params: { about: { content: 'New content' } }
    assert_flash(:success)
    assert_redirected_to about_url
  end

  test 'PATCH update failure' do
    sign_in @user

    patch about_url, params: { about: { content: '' } }
    
    assert_response :success
    assert_flash(:error)
  end
end
