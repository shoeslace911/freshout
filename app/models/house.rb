class House < ApplicationRecord
  has_many :users, dependent: :destroy
end
