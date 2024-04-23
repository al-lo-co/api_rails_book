class ProductBlueprint < Blueprinter::Base
  identifier :id
  fields :title, :price, :published

  view :extended do
    association :user, blueprint: UserBlueprint
  end
end
