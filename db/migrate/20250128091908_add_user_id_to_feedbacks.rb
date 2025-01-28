class AddUserIdToFeedbacks < ActiveRecord::Migration[7.2]
  def change
    add_column :feedbacks, :user_id, :integer
    add_reference :feedbacks, :user, foreign_key: true
  end
end
