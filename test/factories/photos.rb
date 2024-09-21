FactoryBot.define do
  factory :photo do
    user
    event_date { Time.zone.today }
    photo_album
    image { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/test.png'), 'image/png') }
  end
end
