require 'application_system_test_case'

class PackagesTest < BaseSystemTest
  setup do
    @package = FactoryBot.create(:package)
    sign_in @package.user
  end

  test 'visiting the index' do
    visit packages_url
    assert_selector 'h1', text: 'Package List'
  end

  test 'creating a Package' do
    visit new_package_url

    fill_in_rich_text_area 'package_content', with: 'New package description'
    fill_in :package_name, with: 'New Package'
    fill_in :package_price, with: 2
    check 'package[enabled]'
    fill_in :package_position, with: '1'
    click_on 'Create Package'

    assert_text 'Package was successfully created'
  end

  test 'create an invalid Package' do
    visit new_package_url

    fill_in :package_price, with: 2
    check 'package[enabled]'
    fill_in :package_position, with: '1'
    click_on 'Create Package'

    assert_text 'There were errors'
  end

  test 'updating a Package' do
    visit edit_package_url(@package)

    fill_in_rich_text_area 'package_content', with: 'Updated package description'
    fill_in :package_price, with: 3.00
    fill_in :package_position, with: '2'
    click_on 'Update Package'

    assert_text 'Package was successfully updated'
  end

  test 'update an invalid Package' do
    visit edit_package_url(@package)

    fill_in_rich_text_area 'package_content', with: ''
    fill_in :package_price, with: 3.00
    fill_in :package_position, with: '2'
    click_on 'Update Package'

    assert_text 'There were errors'
  end

  test 'destroying a Package' do
    visit packages_url
    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Package was successfully deleted.'
  end
end
