class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< Updated upstream
         :recoverable, :rememberable, :validatable, :confirmable
=======
<<<<<<< Updated upstream
         :recoverable, :rememberable, :validatable
=======
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  
>>>>>>> Stashed changes
>>>>>>> Stashed changes
end
