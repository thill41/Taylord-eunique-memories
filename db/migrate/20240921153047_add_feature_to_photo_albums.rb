class AddFeatureToPhotoAlbums < ActiveRecord::Migration[7.2]
  def change
    add_column :photo_albums, :feature, :boolean, default: false, null: false
  end
end
