module ApplicationHelper
  def flash_alert
    return if flash[:alert].blank?

    render("layouts/alert")
  end

  def flash_success
    # FIXME: message shows without CSS
    return if flash[:success].blank?

    render("layouts/success")
  end

  def flash_error
    return if flash[:error].blank?

    render("layouts/error")
  end

  def flash_notice
    return if flash[:notice].blank?

    render("layouts/notice")
  end

  def error_messages_for(obj)
    return if obj.errors.none?

    render("layouts/error_messages_for", obj:)
  end

  def authentication_action
    if user_signed_in?
      link_to('Sign Out', destroy_user_session_path, data: { turbo_method: :delete })
    else
      link_to('Sign In', new_user_session_path) + ' | ' +  link_to('Sign Up', new_user_registration_path)
    end
  end
end
