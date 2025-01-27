class CreateFoodClaims < ActiveRecord::Migration[7.2]
  def change
    create_table :food_claims do |t|
      t.text :claimed_quantity
      t.text :claim_status
      t.references :food_transactions, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true
      t.timestamps
    end
  end
end
