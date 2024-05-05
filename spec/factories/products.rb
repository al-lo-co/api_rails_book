FactoryBot.define do
  factory :product do
    title { Faker::FunnyName.name }
    price { Faker::Number.between(from: 1, to: 10) }
    user factory: :user
  end
end
