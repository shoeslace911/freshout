class ShoppingList < ApplicationRecord
  belongs_to :house
  belongs_to :house_food
end
