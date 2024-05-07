FactoryBot.define do
  factory :product do
    title { Faker::FunnyName.name }
    price { Faker::Number.between(from: 1, to: 10) }
    quantity { Faker::Number.between(from: 3, to: 5) }
    user factory: :user
  end
end
