FactoryBot.define do
  factory :recipe_food do
    association :food, factory: :food
    association :recipe, factory: :recipe
    quantity { Faker::Number.between(from: 1, to: 10) }
  end
end
