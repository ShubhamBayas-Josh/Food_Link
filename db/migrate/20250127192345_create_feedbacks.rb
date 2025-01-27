class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.text :comment
      t.references :users, null: false, foreign_key: true
      t.references :food_transactions, null: false, foreign_key: true
      t.timestamps
    end
  end
end
