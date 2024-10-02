FactoryBot.define do
  factory :package do
    user
    name { 'My Package' }
    price { 1.50 }
    content { 'My description' }
    position { rand 1..10 }
    enabled { true }
  end
end
