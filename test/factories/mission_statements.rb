FactoryBot.define do
  factory :mission_statement do
    user
    statement { 'Our Mission: Delivering Excellence Every Day' }
    content { 'We are committed to delivering excellence in every aspect of our business. From the quality of our products to the service we provide, we are dedicated to exceeding the expectations of our customers. We strive to be the best in our industry and to be a company that our customers can trust.' }
  end
end
