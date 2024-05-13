FactoryBot.define do
  factory :placement do
    order factory: :user
    product factory: :product
    quantity { Faker::Number.between(from: 3, to: 5) }
  end
end
