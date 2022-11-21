class Food < ApplicationRecord

  has_many :house_food, dependent: :destroy
  validates :name, presence: true

end
