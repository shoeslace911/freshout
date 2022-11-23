class Food < ApplicationRecord
  has_many :shopping_list, through: :items, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :house_food, dependent: :destroy
  validates :name, presence: true

end
