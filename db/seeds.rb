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
      published: true
    )
    puts "created product #{ product.title }"
  end

  2.times do
    order = user.orders.create!(
      total: rand(1.0..100.0),
      products: user.products  
    )
    puts "created order #{ order.total }"
  end
end