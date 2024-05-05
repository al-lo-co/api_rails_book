FactoryBot.define do
  factory :order do
    user factory: :user
    products {[association(:product)]}
  end
end
