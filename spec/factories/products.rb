FactoryBot.define do
  factory :product do
    title { Faker::FunnyName.name }
    price { 1.1 }
    user factory: :user
  end
end
