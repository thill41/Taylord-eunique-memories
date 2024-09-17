module PhotoAlbumsHelper
  def no_photos_message(photo_album)
    return if photo_album.photos.any?

    tag.p "No photos in this album yet. #{link_to 'Add photos', new_photo_album_photo_path(photo_album) if user_signed_in?}".html_safe
  end

  def new_photo_button(photo_album)
    return unless user_signed_in?

    link_to("New Photo", new_photo_album_photo_path(photo_album), class: 'primary-button')
  end

  def cancel_photo_link(photo)
    return unless user_signed_in?

    link_to(:Cancel, (photo.new_record? ? photo.photo_album : photo_album_photo_path(photo.photo_album, photo)), class: 'primary-button')
  end

  def cancel_button(photo_album)
    link_to 'Cancel', (photo_album.persisted? ? photo_album_path(photo_album) : photo_albums_path), class: 'secondary-button'
  end

  def photo_actions(photo)
    return unless user_signed_in?
    
    tag.div class: 'actions' do
      "#{link_to :Edit, edit_photo_album_photo_path(photo.photo_album, photo), class: 'primary-button'} #{button_to :Delete, photo_album_photo_path(photo.photo_album, photo), method: :delete, class: 'secondary-button', data: { turbo_confirm: 'Are you sure you? This can\'t be undone!' }}".html_safe
    end
  end
end
