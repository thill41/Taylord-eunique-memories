require 'application_system_test_case'

class PhotosTest < BaseSystemTest
  setup do
    @user = create(:user)
    @photo_album = create(:photo_album, user: @user)
    @photo = create(:photo, photo_album: @photo_album, user: @user)
  end

  test 'visiting the index' do
    sign_in @user

    visit photo_album_photos_url(@photo_album)
    
    assert_selector 'h1', text: "Photos for #{@photo_album.title}"
  end

  test 'should show photo' do
    visit photo_album_url(@photo_album)

    assert_selector '.lightbox-overlay', count: 0

    find('.img-container').click

    # display photo in overlay of album
    assert_selector '.lightbox-overlay'
  end

  test 'should create photo' do
    sign_in @user

    visit new_photo_album_photo_url(@photo_album)

    fill_in :photo_description, with: 'New Photo Description'
    attach_file 'Image', Rails.root.join('test/fixtures/files/test.png')
    click_on 'Create Photo'

    assert_text 'Photo was successfully created'
    assert_equal edit_photo_album_photo_url(@photo_album, Photo.last), current_url
  end

  test 'should update photo' do
    sign_in @user

    visit edit_photo_album_photo_url(@photo_album, @photo)
    
    fill_in 'Description', with: 'Updated Photo Description'
    click_on 'Update Photo'

    assert_text 'Photo was successfully updated'
    assert_equal edit_photo_album_photo_url(@photo_album, Photo.last), current_url
  end

  test 'should destroy photo' do
    sign_in @user

    visit photo_album_photos_url(@photo_album)
    
    page.accept_confirm do
      click_on 'Delete', match: :first
    end

    assert_text 'Photo was successfully deleted'
    assert_equal photo_album_photos_url(@photo_album), current_url
  end
end
