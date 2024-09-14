FactoryBot.define do
  factory :photo_album do
    user
    sequence(:title) { |n| "Photo Album #{n}" }
  end
end
