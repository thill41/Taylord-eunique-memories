class Contact
  include ActiveModel::Model

  attr_accessor :event_type,
                :email,
                :event_date,
                :first_name,
                :last_name,
                :message,
                :package_id,
                :phone,
                :reference

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :event_date, presence: true
  validates :event_type, presence: true,
                         inclusion: { in: ['Wedding', 'Birthday', 'Graduation', 'Corporate Party', 'Conference', 'Other'] }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :last_name, presence: true
  validates :message, presence: true, length: { minimum: 10 }
  validates :package_id, presence: true
  validates :phone, presence: true
  validates :reference, presence: true

  def submit
    if valid?
      ContactMailer.with(
        email: email,
        event_date: event_date,
        event_type: event_type,
        first_name: first_name,
        last_name: last_name,
        message: message,
        package_id: package_id,
        phone: phone,
        reference: reference
      ).contact_email.deliver_now
      
      true
    else
      false
    end
  end
end
