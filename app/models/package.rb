class Package < ApplicationRecord
  belongs_to :user
  validates :name, :statement, :price, :position, presence: true
end
