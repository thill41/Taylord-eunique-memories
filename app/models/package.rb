class Package < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, :price, :position, presence: true

  scope :enabled, -> { where(enabled: true) }
end
