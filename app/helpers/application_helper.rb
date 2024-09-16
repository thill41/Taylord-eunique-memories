module ApplicationHelper
  def flash_alert
    return if flash[:alert].blank?

    render('layouts/alert')
  end

  def flash_success
    # FIXME: message shows without CSS
    return if flash[:success].blank?

    render('layouts/success')
  end

  def flash_error
    return if flash[:error].blank?

    render('layouts/error')
  end

  def flash_notice
    return if flash[:notice].blank?

    render('layouts/notice')
  end

  def error_messages_for(obj)
    return if obj.errors.none?

    render('layouts/error_messages_for', obj:)
  end

  def authentication_action
    if user_signed_in?
      link_to('Sign Out', destroy_user_session_path, data: { turbo_method: :delete })
    else
      link_to('Sign In', new_user_session_path) + ' | ' + link_to('Sign Up', new_user_registration_path)
    end
  end

  def navbar_links(options = {})
    links = default_links

    if user_signed_in?
      links.concat(signed_in_links(options))
    else
      links.concat(signed_out_links)
    end

    links.map { |link| build_nav_item(link) }.join.html_safe
  end

  private

  def default_links
    [
      { name: 'About', path: about_path, args: { class: "nav-link #{'active' if current_page?(about_path)}" } },
      { name: 'Gallery', path: photo_albums_path, args: { class: "nav-link #{'active' if current_page?(photo_albums_path)}" } }
    ]
  end

  def signed_in_links(options)
    links = []

    if current_page?(photo_albums_path)
      links << { name: 'New Gallery', path: new_photo_album_path, args: { class: "nav_link #{'active' if current_page?(new_photo_album_path)}" } }
    end

    if (album = options[:photo_album]).present?
      links.concat(album_links(album))
    end

    if (photo = options[:photo]).present?
      links.concat(photo_links(photo))
    end

    links << { name: 'Sign Out', path: destroy_user_session_path, args: { data: { turbo_method: :delete }, class: 'nav-link' } }
    links
  end

  def signed_out_links
    [{ name: 'Sign In', path: new_user_session_path, args: { class: 'nav_link' } }]
  end

  def album_links(album)
    links = []
    
    return links if album.id.blank?

    if current_page?(photo_album_path(album))
      links << { name: 'New Photo', path: new_photo_album_photo_path(album), args: { class: "nav_link #{'active' if current_page?(new_photo_album_photo_path(album))}" } }
      links << { name: 'Edit Gallery', path: edit_photo_album_path(album), args: { class: "nav_link #{'active' if current_page?(edit_photo_album_path(album))}" } }
    end

    return links unless album.respond_to?(:id)

    if current_page?(edit_photo_album_path(album))
      links << { name: 'Delete Gallery', path: photo_album_path(album), args: { data: { turbo_method: :delete }, class: 'nav-link' } }
    end
    links
  end

  def photo_links(photo)
    links = []

    return links if photo.id.blank?

    if current_page?(photo_album_photo_path(photo.photo_album, photo))
      links << { name: 'Delete Photo', path: photo_album_photo_path(photo.photo_album, photo), args: { data: { turbo_method: :delete }, class: 'nav-link' } }
    end

    links
  end

  def build_nav_item(link)
    args = { class: 'nav-link' }.merge(link[:args] || {})
    content_tag(:li, class: 'nav-item') do
      link_to link[:name], link[:path], args
    end
  end
end
