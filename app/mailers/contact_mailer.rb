class ContactMailer < ApplicationMailer
  default to: ENV.fetch('LIVEMAIL', 'false') == 'true' ? Rails.application.credentials.dev_email : Rails.application.credentials.email

  def contact_email
    @event_date = params[:event_date]
    @event_type = params[:event_type]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @message = params[:message]
    @package = Package.find(params[:package_id])
    @phone = params[:phone]
    @reference = params[:reference]

    mail(from: params[:email],
         subject: I18n.t('contact_mailer.subject', first_name: @first_name,
                                                   last_name: @last_name),
         reply_to: params[:email])
  end
end
