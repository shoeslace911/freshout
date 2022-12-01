require "open-uri"
require "faker"

Item.destroy_all
HouseFood.destroy_all
User.destroy_all
House.destroy_all
ShoppingList.destroy_all
Food.destroy_all

Food.create!(name: "salmon")
Food.create!(name: "potatoes")
Food.create!(name: "onion")

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
  HouseFood.create!(
    food: foods,
    house: House.first,
    bought_date: Faker::Date.between(from: Date.today, to: '2022-12-31'),
    expiry_date: Faker::Date.between(from: '2022-12-01', to: '2022-12-31'),
    comment: '',
    measurement: "bag",
    amount: rand(1..4),
    owned: true
  )

  # puts "Created #{house_food.name} as a house food."
end
puts "House foods created"
User.create!(username: 'will_hargrave', email: 'will@will.com', password: 123456, house: House.first)
User.create!(username: 'sho_fujiwara', email: 'sho@sho.com', password: 123456, house: House.first)

6.times do
  Item.create!(
    shopping_list: ShoppingList.first,
    food: Food.all.sample,
    amount: 6,
    user: User.all.sample,
    seen: false
  )
end
puts "Items created"

puts "Users created"

puts "Created #{Food.count} foods, #{House.count} houses, #{HouseFood.count} house foods, #{User.count} users, #{ShoppingList.count} shopping list, #{Item.count} items."
