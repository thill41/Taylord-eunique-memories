class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :photo_album

  has_one_attached :image

  scope :cover, -> { where(cover_photo: true) }

  validates :image, attached: true, content_type: %i[png jpeg gif]
  validate :only_one_cover_photo

  private

  def only_one_cover_photo
    return unless cover_photo && (photo_album.photos.cover - Array(cover_photo)).count.positive?

    errors.add(:cover_photo, 'only one cover photo is allowed')
  end
end
