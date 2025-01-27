class Feedback < ApplicationRecord
  validates :rating, presence: true
  validates :comment, presence: true
  belongs_to :user
  belongs_to :food_transaction
end
