class CreatePhotos < ActiveRecord::Migration[7.2]
  def change
    create_table :photos do |t|
      t.references :user
      t.references :photo_album
      t.boolean :cover_photo, null: false, default: false
      t.string :description
      t.timestamps
    end
  end
end
