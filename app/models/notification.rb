class Notification < ApplicationRecord
  validates :type, presence: true
  validates :message, presence: true
  validates :status, presence: true
  belongs_to :user
end
