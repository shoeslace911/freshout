class House < ApplicationRecord
  has_many :shopping_lists, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :house_foods
  has_many :items, through: :users

  validates :name, presence: true
end
