FactoryBot.define do
  factory :about do
    user
    content { Faker::Lorem.paragraph }
  end

  factory :enabled_about, parent: :about do
    enabled { true }
  end

  factory :disabled_about, parent: :about do
    enabled { false }
  end
end
