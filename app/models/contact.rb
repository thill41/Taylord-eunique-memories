class Contact
  include ActiveModel::Model

  attr_accessor :event_type,
                :first_name,
                :last_name,
                :event_date,
                :email,
                :phone,
                :reference,
                :message

  validates :event_type, :first_name, :last_name, :event_date, :phone, :reference, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 10 }
  validates :event_type, inclusion: { in: ['Wedding', 'Birthday', 'Graduation', 'Corporate Party', 'Conference', 'Other'] }

  def submit
    if valid?
      ContactMailer.with(
        event_type: event_type,
        first_name: first_name,
        last_name: last_name,
        event_date: event_date,
        email: email,
        phone: phone,
        reference: reference,
        message: message
      ).contact_email.deliver_now
      
      true
    else
      false
    end
  end
end
