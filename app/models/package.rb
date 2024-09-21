class Package < ApplicationRecord
  belongs_to :user

  validates :name, :statement, :price, :position, presence: true

  scope :enabled, -> { where(enabled: true) }
end
