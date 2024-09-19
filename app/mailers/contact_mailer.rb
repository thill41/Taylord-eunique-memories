class ContactMailer < ApplicationMailer
  default to: Rails.application.credentials.email

  def contact_email
    @event_type = params[:event_type]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @event_date = params[:event_date]
    @phone = params[:phone]
    @reference = params[:reference]
    @message = params[:message]

    mail(from: params[:email], subject: 'Contact Form Message', reply_to: params[:email])
  end
end
