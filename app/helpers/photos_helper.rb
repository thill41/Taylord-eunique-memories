module PhotosHelper
  def photo_description(photo)
    return unless photo.photo_album.photo_message
    
    tag.p photo.photo_album.photo_message, class: 'photo-description'
  end
end
