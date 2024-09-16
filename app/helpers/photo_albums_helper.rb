module PhotoAlbumsHelper
  def no_photos_message(photo_album)
    return if photo_album.photos.any?

    tag.p "No photos in this album yet. #{link_to 'Add photos', new_photo_album_photo_path(photo_album) if user_signed_in?}".html_safe
  end

  def cancel_button(photo_album)
    link_to 'Cancel', (photo_album.persisted? ? photo_album_path(photo_album) : photo_albums_path), class: 'secondary-button'
  end

  def photo_actions(photo)
    return unless user_signed_in?
    
    tag.div class: 'actions' do
      "#{link_to 'Edit Photo', edit_photo_album_photo_path(photo.photo_album, photo), class: "primary-button"} #{button_to 'Delete Photo', photo_album_photo_path(photo.photo_album, photo), method: :delete, data: { confirm: 'Are you sure?' }, class: 'secondary-button'}".html_safe
    end
  end
end
