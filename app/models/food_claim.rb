class FoodClaim < ApplicationRecord
  # Validations
  validates :claimed_quantity, presence: true
  validates :claim_status, presence: true, inclusion: { in: [ "pending", "approved", "rejected", "in_progress" ], message: "%{value} is not a valid status" }

  # Associations
  belongs_to :user
  belongs_to :food_transaction
  belongs_to :creator_user, class_name: "User"

  validates :creator_user, presence: true
  enum :claim_status, { "pending" => "pending", "approved" => "approved", "rejected" => "rejected", "in_progress" => "in_progress" }
  validates :claimed_quantity, presence: true, format: { with: /\A[1-9][0-9]*\z/, message: "must be a positive integer" }
end
