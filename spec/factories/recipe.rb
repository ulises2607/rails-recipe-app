FactoryBot.define do
    factory :recipe do
      sequence(:name) { |n| "Recipe #{n}" }
      preparation_time { Faker::Number.between(from: 10, to: 60) }
      cooking_time { Faker::Number.between(from: 10, to: 60) }
      description { Faker::Lorem.paragraph }
        public { Faker::Boolean.boolean }
      user
    end
end