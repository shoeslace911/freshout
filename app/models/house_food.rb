class HouseFood < ApplicationRecord
  belongs_to :food
  belongs_to :house
end
