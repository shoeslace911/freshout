class HouseFood < ApplicationRecord
  belongs_to :food
  belongs_to :house
  # has_one_attached :photo
  # should remove the photo from the House_food but instead should be in
  # the food table itself
  validates :amount, presence: true
  validates :bought_date, presence: true
  validates :expiry_date, presence: true
end
