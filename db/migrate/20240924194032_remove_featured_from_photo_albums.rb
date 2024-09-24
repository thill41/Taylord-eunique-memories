class RemoveFeaturedFromPhotoAlbums < ActiveRecord::Migration[7.2]
  def change
    remove_column :photo_albums, :feature, :boolean
  end
end
