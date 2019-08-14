FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    author { Faker::Lorem.word }
    page { Faker::Number.number(2) }
    text { Faker::Lorem.paragraph }
  end
end
