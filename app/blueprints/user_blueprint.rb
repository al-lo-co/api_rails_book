class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :email

  field :title do |user|
    user.email.split('@').first
  end

  view :extended do
    association :products, blueprint: ProductBlueprint
  end
end
