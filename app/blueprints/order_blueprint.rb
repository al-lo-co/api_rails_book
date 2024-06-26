class OrderBlueprint < Blueprinter::Base
  identifier :id
  field :total

  view :extended do
    association :user, blueprint: UserBlueprint
    association :products, blueprint: ProductBlueprint
  end
end
