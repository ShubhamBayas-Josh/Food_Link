class AddUserIdToFoodClaims < ActiveRecord::Migration[7.2]
  def change
    add_column :food_claims, :user_id, :integer
    add_reference :food_claims, :user, foreign_key: true
  end
end
