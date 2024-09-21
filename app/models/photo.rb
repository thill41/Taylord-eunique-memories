class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :photo_album

  has_one_attached :image

  validates :image, attached: true, content_type: %i[png jpeg gif]
end
