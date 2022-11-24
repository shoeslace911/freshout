require "open-uri"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Destroying previous seeds...'
Food.destroy_all
puts "Food destroyed"

House.destroy_all
puts "House destroyed"

HouseFood.destroy_all
puts "House food destroyed"

ShoppingList.destroy_all
puts "Shopping list destroyed"

Item.destroy_all
puts "Item destroyed."

puts 'Creating seeds...'

House.create!(
  name: "Will's house"
)
puts "House created"

ShoppingList.create!(
  house: House.first
)
puts "Shopping list created"

fruits_list = ['Pineapple', 'Banana', 'Orange', 'Grape', 'Apple', 'Strawberry', 'Kiwi', 'Melon']
vegetables_list = ['Potato', 'Carrot', 'Letuce', 'Cabbage', 'Peppers', 'Onion', 'Broccoli', 'Cucumber']

6.times do
  fruit = fruits_list.sample
  vegetable = vegetables_list.sample

  fruits = Food.new(
    name: fruit,
    category: 'Fruit'
  )
  vegetables = Food.new(
    name: vegetable,
    category: 'Vegetables'
  )

  fruits_list.delete(fruit)
  vegetables_list.delete(vegetable)

  fruits.save!
  vegetables.save!
end
puts "Foods created"

foods = Food.all
12.times do
  food = foods.sample
  house_food = HouseFood.create!(
    food: food,
    house: House.first,
    bought_date: Faker::Date.between(from: '2023-01-01', to: '2023-01-04'),
    expiry_date: Faker::Date.between(from: '2023-01-04', to: '2023-01-08'),
    comment: '',
    amount: rand(1..4),
    owned: true
  )
  file = URI.open("https://source.unsplash.com/random/?#{house_food.food.name}-#{house_food.food.category}")
  house_food.food.photo.attach(io: file, filename: "nes.png", content_type: "image/png")
  puts "Created #{house_food.food.name} as a house food."

  foods -= [food]
end
puts "House foods created"

6.times do
  Item.create!(
    shopping_list: ShoppingList.first,
    food: Food.all.sample,
    amount: 6
  )
end
puts "Items created"

# House has to exist before user, this is a problem
User.create!(username: 'will_hargrave', email: 'will@will.com', password: 123456, house: House.first)
User.create!(username: 'sho_fujiwara', email: 'sho@sho.com', password: 123456, house: House.first)
puts "Users created"

puts "Created #{Food.count} foods, #{House.count} houses, #{HouseFood.count} house foods, #{User.count} users, #{ShoppingList.count} shopping list, #{Item.count} items."
