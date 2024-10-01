require 'application_system_test_case'

class MissionStatementsTest < BaseSystemTest
  setup do
    @user = create(:user)
    create(:about, user: @user)
    create(:mission_statement, user: @user, content: 'test text')
  end

  test 'viewing the mission statement' do
    visit mission_statement_path
    assert_text 'Mission Statement'
  end

  test 'updating the mission statement' do
    visit root_path
    assert_selector 'a', text: 'Manage Mission Statement', count: 0

    sign_in @user
    visit edit_mission_statement_path
  
    fill_in_rich_text_area 'mission_statement_content', with: 'Updated mission statement'
    click_on 'Save'
  
    assert_text 'Mission Statement was successfully updated'
    assert_selector '.trix-content', text: 'Updated mission statement'
  end
  
  test 'failing to update the mission statement' do
    sign_in @user
    visit edit_mission_statement_path
  
    fill_in_rich_text_area 'mission_statement_content', with: ''
    click_on 'Save'
  
    assert_text "Content can't be blank"
  end  
end
