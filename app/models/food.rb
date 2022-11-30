class Food < ApplicationRecord
  has_many :shopping_list, through: :items
  has_many :items, dependent: :destroy
  has_many :house_food, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  has_one_attached :photo
  before_validation :add_expiry
  # to add photo for the food
  def add_expiry
    self.expiry_days = 32 if expiry_days.nil?
    case category
    when "fruit"
      self.expiry_days = 8
    when "Vegetables".downcase
      self.expiry_days = 20
    when 'wines', 'condiments and sauces', "Condiments and sauces", "plant-based protein"
      self.expiry_days = 365
    when 'Milk', 'yogurt', "bread, rolls and tortillas", "Dairy", "dairy", "eggs", "Eggs"
      self.expiry_days = 7
    when 'grain', 'Grain', 'Grains', 'grains'
      self.expiry_days = 250
    else
      self.expiry_days = 32
    end
  end
end
