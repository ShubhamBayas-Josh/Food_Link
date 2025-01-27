class FoodClaim < ApplicationRecord
  validates :claimed_quantity, presence: true
  validates :claim_status, presence: true
  belongs_to :user
  belongs_to :food_transaction
end
