module PhotoAlbumsHelper
  def no_photos_message(photo_album)
    return if photo_album.photos.any?

    tag.p "No photos in this album yet. #{link_to 'Add photos', new_photo_album_photo_path(photo_album) if user_signed_in?}".html_safe
  end

  def cancel_button(photo_album)
    link_to 'Cancel', (photo_album.persisted? ? photo_album_path(photo_album) : photo_albums_path), class: 'btn btn-secondary'
  end
end
