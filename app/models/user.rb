class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :name, presence: true
  validates :role, presence: true
  validates :address, presence: true

  has_many :feedbacks
  has_many :food_claims
  has_many :food_transactions
  has_many :notifications
end
