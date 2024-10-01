require 'application_system_test_case'

class AboutsTest < BaseSystemTest
  setup do
    @user = create(:user)
    create(:about, user: @user)
    create(:mission_statement, user: @user)
  end

  test 'updating an about' do
    visit root_path
    assert_selector 'a', text: 'Manage About', count: 0

    sign_in @user

    visit root_path
    click_on 'Manage About', match: :first

    fill_in_rich_text_area 'about_content', with: 'Updated about content'
    click_on 'Update About'

    assert_text 'About was successfully updated'
  end

  test 'failing to update an about' do
    sign_in @user

    visit edit_about_path
    fill_in_rich_text_area 'about_content', with: ''
    click_on 'Update About'

    assert_text "Content can't be blank"
  end
end
