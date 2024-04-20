User.delete_all
Product.delete_all

5.times do 
  user = User.create!(email: Faker::Internet.email, password: 'password')
  puts "created user #{ user.email }"

  2.times do
   product = Product.create!(
    title: Faker::Commerce.product_name,
    price: rand(1.0..100.0),
    published: true,
    user_id: user.id
   )
   puts "created product #{ product.title }"
  end
end