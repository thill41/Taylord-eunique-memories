module ApplicationHelper
  def flash_alert
    return if flash[:alert].blank?

    render('layouts/alert')
  end

  def flash_success
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

  def authentication_actions
    content_tag(:li, class: 'nav-item') do
      if user_signed_in?
        link_to('Sign Out', destroy_user_session_path, data: { turbo_method: :delete }, class: 'nav-link')
      else
        link_to('Sign In', new_user_session_path, class: 'nav-link')
      end
    end
  end
end
