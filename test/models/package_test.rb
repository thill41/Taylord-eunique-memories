require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should have_rich_text(:content)
  end

  context 'validates' do
    should validate_presence_of(:name)
    should validate_presence_of(:price)
    should validate_presence_of(:position)
    should validate_numericality_of(:price).is_greater_than_or_equal_to(0)
  end
end
  