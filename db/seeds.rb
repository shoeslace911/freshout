require "open-uri"
require "faker"

House.create!(
  name: "#{Faker::Name.last_name}'s house"
)
puts "House created"

ShoppingList.create!(
  house: House.first
)
puts "Shopping list created"
10.times do
  foods = Food.all.uniq.sample
  house_food = HouseFood.where(food: foods).find_or_create_by(
    food: foods,
    house: House.first,
    bought_date: Faker::Date.between(from: '2023-01-01', to: '2023-01-04'),
    expiry_date: Faker::Date.between(from: '2023-01-04', to: '2023-01-08'),
    comment: '',
    amount: rand(1..4),
    owned: true
  )

  puts "Created #{house_food.food.name} as a house food."
end
puts "House foods created"

6.times do
  Item.create(
    shopping_list: ShoppingList.first,
    food: foods.sample
  )
end
puts "Items created"

# House has to exist before user, this is a problem
User.create!(username: 'will_hargrave', email: 'will@will.com', password: 123456, house: House.first)
User.create!(username: 'sho_fujiwara', email: 'sho@sho.com', password: 123456, house: House.first)
puts "Users created"

puts "Created #{Food.count} foods, #{House.count} houses, #{HouseFood.count} house foods, #{User.count} users, #{ShoppingList.count} shopping list, #{Item.count} items."
