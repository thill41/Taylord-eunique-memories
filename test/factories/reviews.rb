FactoryBot.define do
  factory :review do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'fake-email@example.com' }
    rating { rand(1..10) }
    content { 'This is a sample review content.' }
  end
end
