class Food < ApplicationRecord
  has_many :house_food, dependent: :destroy
end
