class MoveEventDateFromPhotosToPhotoAlbums < ActiveRecord::Migration[7.2]
  def change
    remove_column :photos, :event_date, :date
    add_column :photo_albums, :event_date, :date
  end
end
