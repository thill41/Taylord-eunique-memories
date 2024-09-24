require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should have_one_attached(:image)
  end

  context 'validates' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:position)
  end
end
