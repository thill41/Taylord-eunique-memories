# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview
  def contact_email
    ContactMailer.with(
      event_type: 'Wedding',
      first_name: 'John',
      last_name: 'Doe',
      event_date: '2021-12-31',
      email: 'jdoe@email.test',
      phone: '1-800-867-5309',
      reference: 'A friend',
      message: Faker::Lorem.paragraph
    ).contact_email
  end
end
