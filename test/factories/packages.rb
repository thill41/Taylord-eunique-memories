FactoryBot.define do
  factory :package do
    user
    sequence(:name) { |n| "Package #{n}" }
    price { 1.50 }
    description { 'My description' }
    position { rand 1..10 }
    enabled { true }
  end
end
