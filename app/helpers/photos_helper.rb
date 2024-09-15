module PhotosHelper
  def cancel_button(photo)
    link_to 'Cancel', (photo.persisted? ? photo_album_photo_path(photo) : photo_album_path(photo.photo_album)), class: 'btn btn-secondary'
  end
end
