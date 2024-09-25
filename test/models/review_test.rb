require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:rating)
    should validate_presence_of(:content)
    should validate_presence_of(:email)
    should validate_length_of(:content).is_at_least(10)
  end

  test 'should be valid with valid attributes' do
    assert Review.new(attributes_for(:review)).valid?
  end
end
