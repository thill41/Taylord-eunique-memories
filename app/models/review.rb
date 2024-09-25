class Review < ApplicationRecord
  validates :email, :rating, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
