require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :first_name
    should validate_presence_of :last_name
    should validate_presence_of :username
    should validate_uniqueness_of(:username).case_insensitive
  end

  context 'associations' do
    should have_one :about
  end
end
