class CreatePhotoAlbums < ActiveRecord::Migration[7.2]
  def change
    create_table :photo_albums do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.timestamps
    end
  end
end
