require 'test_helper'

class PhotoFlowsTest < BaseIntegrationTest
  setup do
    @user = create(:user)
    @photo_album = create(:photo_album, user: @user)
    @photo = create(:photo, user: @user, photo_album: @photo_album)
  end

  test 'require authentication' do
    requires_authentication { get new_photo_album_photo_url(@photo_album) }
    requires_authentication { post photo_album_photos_url(@photo_album), params: { photo: { image: fixture_file_upload('test.png', 'image/png') } } }
    requires_authentication { get edit_photo_album_photo_url(@photo_album, @photo) }
    requires_authentication { put photo_album_photo_url(@photo_album, @photo), params: { photo: { description: 'test upload' } } }
    requires_authentication { delete photo_album_photo_url(@photo_album, @photo) }
  end

  test 'get a photo' do
    get photo_album_photo_url(@photo_album, @photo)

    assert_response :success
    assert_select 'img.full-size-photo'
  end

  test 'creating a photo' do
    sign_in @user

    get new_photo_album_photo_url(@photo_album)

    assert_response :success

    post photo_album_photos_url(@photo_album), params: { photo: { image: fixture_file_upload('test.png', 'image/png') } }

    photo = Photo.last

    assert_redirected_to edit_photo_album_photo_url(@photo_album, photo)
    follow_redirect!
    assert_select "div[role='alert']", success_message(photo)
  end

  test 'creating a photo with invalid data' do
    sign_in @user

    post photo_album_photos_url(@photo_album), params: { photo: { image: nil } }

    assert_response :success
    assert_select "div[role='alert']", error_message
  end

  test 'editing a photo' do
    sign_in @user

    get edit_photo_album_photo_url(@photo_album, @photo)

    assert_response :success

    put photo_album_photo_url(@photo_album, @photo), params: { photo: { description: 'test upload' } }

    assert_redirected_to edit_photo_album_photo_url(@photo_album, @photo)
    follow_redirect!
    assert_select "div[role='alert']", success_message(@photo, :updated)
  end

  test 'editing a photo with invalid data' do
    sign_in @user

    put photo_album_photo_url(@photo_album, @photo), params: { photo: { image: nil } }

    assert_response :success
    assert_select "div[role='alert']", error_message
  end

  test 'destroying a photo' do
    sign_in @user

    delete photo_album_photo_url(@photo_album, @photo)

    assert_response :found
    assert_redirected_to photo_album_url(@photo_album)
    follow_redirect!
    assert_select "div[role='alert']", success_message(@photo, :deleted)
  end
end
