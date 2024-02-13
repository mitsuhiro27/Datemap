FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 10) }
    address { Faker::Address.city }
  end
end
