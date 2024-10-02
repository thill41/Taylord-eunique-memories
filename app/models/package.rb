class Package < ApplicationRecord
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_rich_text :content

  validates :price, :position, :content, :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :enabled, -> { where(enabled: true) }
end
