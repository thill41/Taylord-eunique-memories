# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(
  first_name: 'Joe',
  last_name: 'Smith',
  username: 'jsmith',
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now
)

About.create!(
  content: 'This is the about us page content.',
  user: user
)

2.times do |n|
  user.photo_albums.create!(
    title: "Photo Gallery #{n}"
  )
end

3.times do |n|
  user.packages.create!(
    name: "Package #{n}",
    statement: 'The best thing ever...',
    price: rand(1..100),
    description: 'Get it now or never!',
    enabled: true,
    frequency: 'monthly',
    position: n
  )
end

8.times do
  Review.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    rating: rand(1..10),
    content: Faker::Lorem.paragraph
  )
end

MissionStatement.create!(
  user: user,
  content: 'This is the mission statement content.'
)
