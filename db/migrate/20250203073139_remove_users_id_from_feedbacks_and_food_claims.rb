class RemoveUsersIdFromFeedbacksAndFoodClaims < ActiveRecord::Migration[7.2]
  def change
    remove_column :feedbacks, :users_id, :integer
    remove_column :food_claims, :users_id, :integer
  end
end
