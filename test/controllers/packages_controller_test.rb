require 'test_helper'

class PackagesControllerTest < BaseIntegrationTest
  setup do
    @package = create :package
    sign_in @package.user
  end

  test 'GET index' do
    get packages_url
    assert_response :success
  end

  test 'GET show' do
    get package_url(@package)
    assert_response :success
  end

  test 'GET new' do
    get new_package_url
    assert_response :success
  end

  test 'GET edit' do
    get edit_package_url(@package)
    assert_response :success
  end

  test 'POST create' do
    assert_difference('Package.count') do
      post packages_url, params: { package: { name: 'Test', statement: 'Test', price: 1, position: 1 } }
    end

    assert_redirected_to package_url(Package.last)
    assert_flash(:success)
  end
  
  test 'invalid POST create' do
    assert_no_difference('Package.count') do
      post packages_url, params: { package: { name: 'Test', statement: 'Test', price: 1 } }
    end

    assert_flash(:error)
  end

  test 'PUT update' do
    patch package_url(@package), params: { package: { name: 'Test' } }

    assert_redirected_to package_url(@package)
    assert_flash(:success)
  end

  test 'invalid PUT update' do
    patch package_url(@package), params: { package: { name: nil } }
    
    assert_flash(:error)
  end

  test 'DELETE destroy' do
    assert_difference('Package.count', -1) do
      delete package_url(@package)
    end

    assert_redirected_to packages_url
    assert_flash(:success)
  end
end
