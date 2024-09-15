require 'test_helper'

class PhotoAlbumTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should have_many(:photos)
  end

  context 'validations' do
    should validate_presence_of(:title)
  end
end
