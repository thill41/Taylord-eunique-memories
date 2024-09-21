class RemoveCoverPhotoFromPhotos < ActiveRecord::Migration[7.2]
  def change
    remove_column :photos, :cover_photo, :boolean
  end
end
