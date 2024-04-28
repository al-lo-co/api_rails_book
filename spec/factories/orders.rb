FactoryBot.define do
  factory :order do
    user factory: :user
    total { Faker::Number.between(from: 1, to: 10) }
  end
end
