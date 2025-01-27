class RenameUsersIdToUserIdInFoodTransaction < ActiveRecord::Migration[7.2]
  def change
    rename_column :food_transactions, :users_id, :user_id
  end
end
