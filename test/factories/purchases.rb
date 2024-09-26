FactoryBot.define do
  factory :purchase do
    package
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet }
    stripe_payment_id { Faker::Number.number(digits: 10) }
    status { 'succeeded' }
  end
end
