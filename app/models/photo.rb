class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :photo_album

  has_many_attached :images

  scope :cover, -> { where(cover_photo: true) }

  validate :only_one_cover_photo

  private

  def only_one_cover_photo
    return unless cover_photo && photo_album.photos.cover.count.positive?

    errors.add(:cover_photo, 'only one cover photo is allowed')
  end
end
