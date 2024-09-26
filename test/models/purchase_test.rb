require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:package)
  end

  context 'validations' do
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
  end
end
