class HouseFood < ApplicationRecord
  belongs_to :food
  belongs_to :house
  has_one_attached :photo

  validates :amount, presence: true
  validates :bought_date, presence: true
  validates :expiry_date, presence: true

  include PgSearch::Model
  pg_search_scope :search,
  associated_against: {
    food: [:name]
  },
  using: {
    tsearch: { prefix: true }
  }

end
