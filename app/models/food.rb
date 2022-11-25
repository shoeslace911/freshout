class Food < ApplicationRecord
  has_many :shopping_list, through: :items
  has_many :items, dependent: :destroy
  has_many :house_food, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  has_one_attached :photo
  # to add photo for the food

end
