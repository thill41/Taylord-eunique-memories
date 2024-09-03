class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  add_flash_types :success, :error
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized_request

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, { store_attributes: [:subdomain] }])
  end

  def flash_error_message
    flash.now[:error] = I18n.t('error')
  end

  def success_message(object, status = :created)
    I18n.t('success', class_name: object.class.name.titleize, status: status.to_s)
  end

  def unauthorized_request
    flash[:alert] = I18n.t('authorization')
    redirect_to(root_path)
  end
end
