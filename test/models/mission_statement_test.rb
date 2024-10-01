require 'test_helper'

class MissionStatementTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of :content
  end

  context 'associations' do
    should belong_to :user
  end
end
