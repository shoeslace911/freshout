class User < ApplicationRecord
  belongs_to :house
  has_one_attached :photo
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :services
  has_many :notification, as: :recipient
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
