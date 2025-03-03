class User < ApplicationRecord
  has_secure_password
  # Validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :name, presence: true
  validates :role, presence: true
  validates :address, presence: true

  # Associations with dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :food_claims, dependent: :destroy
  has_many :food_transactions, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
