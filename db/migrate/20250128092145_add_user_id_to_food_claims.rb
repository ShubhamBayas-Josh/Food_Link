class AddUserIdToFoodClaims < ActiveRecord::Migration[7.2]
  def change
    # add_column :food_claims, :integer
    add_reference :food_claims, :user, foreign_key: true
  end
end
