require 'application_system_test_case'

class PhotoAlbumsTest < BaseSystemTest
  setup do
    @user = create(:user)
    @photo_album = create(:photo_album, user: @user)
  end

  test 'visiting the index' do
    visit photo_albums_url

    assert_selector 'a', text: 'New Gallery', count: 0

    sign_in @user

    visit photo_albums_url

    assert_selector 'a', text: 'New Gallery'
  end

  test 'showing a Photo album' do
    visit photo_album_url(@photo_album)

    assert_text "#{PhotoAlbum.last.title} Photos"
    assert_selector 'a', text: 'Back to Listing'
    assert_selector 'a', text: 'Edit Gallery', count: 0
    assert_selector 'a', text: 'Manage Photos', count: 0
    assert_selector 'a', text: 'Add Photo', count: 0
    assert_selector 'a', text: 'Add photos', count: 0
  end

  test 'creating a Photo album' do
    sign_in @user
    
    visit photo_albums_url
    click_on 'New Gallery'

    fill_in :photo_album_title, with: 'My Photo Album'
    fill_in :photo_album_event_date, with: Time.zone.today
    fill_in :photo_album_photo_message, with: 'This is a test photo album.'
    attach_file :photo_album_photo, Rails.root.join('test/fixtures/files/test.png')

    click_on 'Save Gallery'

    assert_text 'Photo Album was successfully created'
    assert_text "#{PhotoAlbum.last.title} Photos"
    assert_selector 'a', text: 'Back to Listing'
    assert_selector 'a', text: 'Edit Gallery'
    assert_selector 'a', text: 'Manage Photos'
    assert_selector 'a', text: 'Add Photo'
    assert_selector 'a', text: 'Add photos'
  end

  test 'updating a Photo album' do
    sign_in @user

    visit edit_photo_album_url(@photo_album)

    fill_in :photo_album_title, with: 'Updated Photo Album'
    click_on 'Save Gallery'

    assert_text 'Photo Album was successfully updated'
  end

  test 'destroying a Photo album' do
    sign_in @user

    visit edit_photo_album_url(@photo_album)

    page.accept_confirm do
      click_on 'Delete Gallery', match: :first
    end

    assert_text 'Photo Album was successfully deleted'
  end
end
