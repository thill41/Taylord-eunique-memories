require 'test_helper'

class MissionStatementFlowsTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @mission_statement = create(:mission_statement, user: @user)
  end

  test 'requires authentication' do
    requires_authentication { get edit_mission_statement_url }
    requires_authentication { patch mission_statement_url, params: { prams: { mission_statement: { content: 'Updated mission statement' } } } }
  end

  test 'should show mission statement' do
    get mission_statement_url(@mission_statement)
    assert_response :success
  end

  test 'should update mission statement' do
    sign_in @user

    patch mission_statement_url, params: { mission_statement: { content: 'Updated mission statement' } }
    assert_redirected_to mission_statement_path(@mission_statement)
    assert_flash(:success)
  end

  test 'should not update mission statement' do
    sign_in @user

    patch mission_statement_url, params: { mission_statement: { content: '' } }
    assert_response :success
    assert_flash(:error)
  end
end
