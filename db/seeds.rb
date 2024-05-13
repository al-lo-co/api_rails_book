User.destroy_all
Product.delete_all
Placement.delete_all

5.times do 
  user = User.create!(email: Faker::Internet.email, password: 'password')
  puts "created user #{ user.email }"
  puts "User token #{ JsonWebToken.encode(user_id: user.id) }"

  2.times do
    product = user.products.create!(
      title: Faker::Commerce.product_name,
      price: rand(1.0..100.0),
      published: true,
      quantity: Faker::Number.between(from: 5, to: 15)
    )
    puts "created product #{ product.title }"
  end

  2.times do
    order = Order.create!(user_id: user.id)
    order.build_placements_with_product_ids_and_quantities(
      [
        { product_id: rand(1..Order.all.size), quantity: 1 },
        { product_id: rand(1..Order.all.size), quantity: 1 }
      ]
    )
    order.save!
    puts "created order #{ order.total }"
  end
end