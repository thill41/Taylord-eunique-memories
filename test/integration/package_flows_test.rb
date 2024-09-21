require 'test_helper'

class PackageFlowsTest < BaseIntegrationTest
  setup do
    @package = create :package
    sign_in @package.user
  end

  test 'requires authentication' do
    sign_out @package.user

    requires_authentication { get packages_path }
    requires_authentication { get new_package_path }
    requires_authentication { post packages_path params: { package: { name: 'New Package', statement: 'New Statement', price: 10, position: 1, description: 'New Description', enabled: true, frequency: 'monthly' } } }
    requires_authentication { get edit_package_path(@package) }
    requires_authentication { patch package_path(@package), params: { package: { name: 'New Name' } } }
    requires_authentication { delete package_path(@package) }
  end

  test 'view packages' do
    get packages_path
    assert_response :success
  end

  test 'creating a package' do
    get new_package_path

    assert_response :success

    post packages_path, params: { package: { name: 'New Package', statement: 'New Statement', price: 10, position: 1, description: 'New Description', enabled: true, frequency: 'monthly' } }

    assert_response :redirect
    assert_redirected_to package_path(Package.last)
    assert_flash(:success)
  end

  test 'invalid create package' do
    post packages_path, params: { package: { name: 'New Package', statement: 'New Statement', price: 10, description: 'New Description', enabled: true } }

    assert_response :success
    assert_flash(:error)
  end

  test 'editing a package' do
    get edit_package_path(@package)

    assert_response :success

    patch package_path(@package), params: { package: { name: 'New Name' } }

    assert_response :redirect
    assert_redirected_to package_path(@package)
    assert_flash(:success)
  end

  test 'invalid edit package' do
    patch package_path(@package), params: { package: { name: nil } }

    assert_response :success
    assert_flash(:error)
  end

  test 'deleting a package' do
    delete package_path(@package)

    assert_response :redirect
    assert_redirected_to packages_path
    assert_flash(:success)
  end
end
