FactoryBot.define do
  factory :photo do
    user
    photo_album
    image { Rack::Test::UploadedFile.new(Rails.root.join('test/fixtures/files/test.png'), 'image/png') }
  end
end
