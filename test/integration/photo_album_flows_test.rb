require 'test_helper'

class PhotoAlbumFlowsTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @photo_album = create(:photo_album, user: @user)
    @photo = create(:photo, user: @user, photo_album: @photo_album)
  end

  test 'require authentication' do
    requires_authentication { get new_photo_album_url }
    requires_authentication { post photo_albums_url, params: { photo_album: { title: 'New Album' } } }
    requires_authentication { get edit_photo_album_url(@photo_album) }
    requires_authentication { put photo_album_url(@photo_album), params: { photo_album: { title: 'Updated Album' } } }
    requires_authentication { delete photo_album_url(@photo_album) }
  end

  test 'getting a list of photo albums' do
    get photo_albums_url

    assert_response :success

    assert_select 'a', text: 'New Gallery', count: 0
  end

  test 'new gallery link visible to user' do
    sign_in @user

    get photo_albums_path

    assert_select 'a', text: 'New Gallery', count: 1
  end

  test 'getting a photo album' do
    get photo_album_url(@photo_album)

    assert_response :success
    assert_select 'h1', text: "#{@photo_album.title} Photos"
    assert_select 'a', text: 'Edit Gallery', count: 0
    assert_select 'a', text: 'Manage Photos', count: 0
    assert_select 'a', text: 'Add Photo', count: 0
  end

  test 'user can manage photo album' do
    sign_in @user

    get photo_album_url(@photo_album)
    
    assert_select 'a', text: 'Edit Gallery'
    assert_select 'a', text: 'Manage Photos'
    assert_select 'a', text: 'Add Photo'
  end

  test 'creating a new photo album' do
    sign_in @user

    get new_photo_album_url

    assert_response :success

    post photo_albums_url, params: { photo_album: { title: 'New Album' } }

    photo_album = PhotoAlbum.last

    assert_redirected_to photo_album_url(photo_album)
    follow_redirect!
    assert_select 'h1', text: 'New Album Photos'
    assert_select "div[role='alert']", success_message(photo_album)
  end

  test 'creating a new photo album with invalid data' do
    sign_in @user

    post photo_albums_url, params: { photo_album: { title: '' } }

    assert_response :success
    assert_select "div[role='alert']", error_message
  end

  test 'editing a photo album' do
    sign_in @user

    get edit_photo_album_url(@photo_album)

    assert_response :success
    assert_select 'button', text: 'Delete Gallery'

    patch photo_album_url(@photo_album), params: { photo_album: { title: 'Updated Album' } }

    assert_redirected_to photo_album_url(@photo_album)
    follow_redirect!
    assert_select 'h1', text: 'Updated Album Photos'
    assert_select "div[role='alert']", success_message(@photo_album, :updated)
  end

  test 'editing a photo album with invalid data' do
    sign_in @user

    patch photo_album_url(@photo_album), params: { photo_album: { title: '' } }

    assert_response :success
    assert_select "div[role='alert']", error_message
  end

  test 'destroying a photo album' do
    sign_in @user

    delete photo_album_url(@photo_album)

    assert_response :found
    assert_redirected_to photo_albums_url
    follow_redirect!
    assert_select "div[role='alert']", success_message(@photo_album, :deleted)
  end
end
