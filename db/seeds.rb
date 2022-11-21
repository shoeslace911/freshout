# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Destroying previous seeds...'
Food.destroy_all
House.destroy_all
HouseFood.destroy_all

puts 'Creating seeds...'
House.create!(
  name: "Will's house"
)

8.times do
  fruits = Food.new(
    name: Faker::Food.fruits,
    category: 'Fruit'
  )
  vegetables = Food.new(
    name: Faker::Food.vegetables,
    category: 'Vegetables'
  )
  fruits.save!
  vegetables.save!
end

8.times do
  foods = Food.all
  food = foods.sample
  HouseFood.create!(
    food: food,
    house: House.first,
    bought_date: Faker::Date.between(from: '2023-01-01', to: '2023-01-04'),
    expiry_date: Faker::Date.between(from: '2023-01-04', to: '2023-01-08'),
    comment: '',
    amount: rand(1..4),
    owned: true
  )
end

# House has to exist before user, this is a problem
User.create!(username: 'will_hargrave', email: 'will@will.com', password: 123456, house: House.first)
User.create!(username: 'sho_fujiwara', email: 'sho@sho.com', password: 123456, house: House.first)

puts "Created #{Food.count} foods, #{House.count} houses, #{HouseFood.count} house foods, #{User.count} users."
