class FoodClaim < ApplicationRecord
  # Validations
  validates :claimed_quantity, presence: true
  validates :claim_status, presence: true, inclusion: { in: [ "pending", "approved", "rejected", "in_progress" ], message: "%{value} is not a valid status" }

  # Associations
  belongs_to :user
  belongs_to :food_transaction
  belongs_to :creator_user, class_name: "User"

  validates :creator_user, presence: true
end
