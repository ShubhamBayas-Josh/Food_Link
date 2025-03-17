class Admin < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :users
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
