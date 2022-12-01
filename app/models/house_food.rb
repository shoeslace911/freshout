class HouseFood < ApplicationRecord
  belongs_to :food
  belongs_to :house
  has_one_attached :photo

  # should remove the photo from the House_food but instead should be in
  # the food table itself
  validates :amount, presence: true
  validates :bought_date, presence: true
  before_validation :add_amount
  before_validation :add_measurement

  MEASUREMENT = ["bag", "bottle", "sack", "loaf", "carton", "can", "jar", "piece", "pint", "slice", "pack", "rash", "bunch", "gram", "ounce", "millimetre", "fluid ounce"]

  include PgSearch::Model
  pg_search_scope :search_for_name_and_category,
  associated_against: {
    food: [:name, :category]
  },
  using: {
    tsearch: { prefix: true }
  }

  def add_amount
    if amount.nil?
      self.amount = 1
    end
  end

  def add_measurement
    if measurement.nil?
      case food.name.downcase
      when 'potatoes' then self.measurement = 'sack'
      when 'onion' then self.measurement = 'bag'
      when 'strawberries' then self.measurement = 'pack'
      end
    end
  end
end
