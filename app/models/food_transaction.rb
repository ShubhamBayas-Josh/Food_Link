class FoodTransaction < ApplicationRecord
  validates :food_type, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :transaction_type, presence: true
  validates :status, presence: true
  validates :expiration_date, presence: true
  belongs_to :user
  has_many :feedbacks
  has_many :food_claims
end
