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

  def navbar_links
    links = [
      { name: 'Gallery', path: '#', args: { class: 'nav-link' } },
      { name: 'About', path: abouts_path, args: { class: 'nav-link' } }
    ]

    if user_signed_in?
      links << { name: 'Edit About', path: edit_abouts_path, args: { class: 'nav-link' } } if current_page?(abouts_path)
    end

    links << { name: 'Sign In', path: new_user_session_path, args: { class: 'nav-link' } } unless user_signed_in?
    links << { name: 'Sign Out', path: destroy_user_session_path, args: { data: { turbo_method: :delete }, class: 'nav-link' } } if user_signed_in?
    

    links.map do |link|
      content_tag(:li, class: 'nav-item') do
        link_to link[:name], link[:path], link[:args]
      end
    end.join.html_safe
  end
end
