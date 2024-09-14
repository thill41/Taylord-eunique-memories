require 'test_helper'

class PhotoAlbumsControllerTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @photo_album = create(:photo_album, user: @user)
  end

  test 'GET index' do
    get photo_albums_url

    assert_response :success
  end

  test 'GET show' do
    get photo_album_url(@photo_album)

    assert_response :success
  end

  test 'GET new' do
    sign_in @user

    get new_photo_album_url

    assert_response :success
  end

  test 'POST create success' do
    sign_in @user

    post photo_albums_url, params: { photo_album: { title: 'New Album' } }

    assert_redirected_to photo_album_url(PhotoAlbum.last)
    assert_flash(:success)
  end

  test 'POST create failure' do
    sign_in @user

    post photo_albums_url, params: { photo_album: { title: '' } }

    assert_response :success
    assert_flash(:error)
  end

  test 'GET edit' do
    sign_in @user

    get edit_photo_album_url(@photo_album)

    assert_response :success
  end

  test 'PUT update success' do
    sign_in @user

    put photo_album_url(@photo_album), params: { photo_album: { title: 'Updated Album' } }

    assert_redirected_to photo_album_url(@photo_album)
    assert_flash(:success)
  end

  test 'PUT update failure' do
    sign_in @user

    put photo_album_url(@photo_album), params: { photo_album: { title: '' } }

    assert_response :success
    assert_flash(:error)
  end

  test 'DELETE destroy' do
    sign_in @user

    delete photo_album_url(@photo_album)

    assert_redirected_to photo_albums_url
    assert_flash(:success)
  end
end
