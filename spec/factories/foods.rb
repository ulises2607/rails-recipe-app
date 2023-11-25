FactoryBot.define do
  factory :food do
    sequence(:name) { |n| "Food #{n}" }
    unit { 'grams' }
    price { Faker::Number.between(from: 1, to: 1000) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    association :user
  end
end
