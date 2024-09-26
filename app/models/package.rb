class Package < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :purchases, dependent: :destroy

  validates :name, :price, :position, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :enabled, -> { where(enabled: true) }
end
