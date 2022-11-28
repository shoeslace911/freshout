class House < ApplicationRecord
  has_many :shopping_lists, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :house_foods
  validates :name, presence: true
end
