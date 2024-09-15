require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should belong_to(:photo_album)
    should have_one_attached(:image)
  end

  context 'validations' do
    should validate_content_type_of(:image).allowing('image/png', 'image/gif', 'image/jpeg')
  end

  test 'error when more than 1 cover photo is selected' do
    photo = FactoryBot.create(:photo, cover_photo: true)
    photo2 = FactoryBot.build(:photo, cover_photo: true, photo_album: photo.photo_album)
    assert_not photo2.valid?
  end
end
