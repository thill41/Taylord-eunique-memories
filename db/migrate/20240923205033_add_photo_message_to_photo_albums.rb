class AddPhotoMessageToPhotoAlbums < ActiveRecord::Migration[7.2]
  def change
    add_column :photo_albums, :photo_message, :string
  end
end
