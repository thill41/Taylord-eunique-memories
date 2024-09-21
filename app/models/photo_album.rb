class PhotoAlbum < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  
  validates :title, presence: true

  scope :featured, -> { where(feature: true) }
end
