class Purchase < ApplicationRecord
  belongs_to :package

  validates :first_name, :last_name, :email, presence: true
end
