class FoodTransaction < ApplicationRecord
  # Define expected statuses and transaction types
  TRANSACTION_STATUSES = [ "pending", "completed", "cancelled", "expired", "in_progress" ].freeze
  TRANSACTION_TYPES = [ "offer", "request" ].freeze

  # Validations
  validates :food_type, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES, message: "%{value} is not a valid transaction type" }
  validates :status, presence: true, inclusion: { in: TRANSACTION_STATUSES, message: "%{value} is not a valid status" }
  validates :expiration_date, presence: true
  validates :user_id, presence: true


  # Associations
  belongs_to :user
  has_many :feedbacks
  has_many :food_claims
  has_many :notifications, dependent: :destroy
end
