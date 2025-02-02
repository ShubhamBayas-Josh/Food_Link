class CreateFoodClaims < ActiveRecord::Migration[7.2]
  def change
    create_table :food_claims do |t|
      t.string :claimed_quantity
      t.string :claim_status
      t.references :food_transaction, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true  # existing reference to the user (claimant)
      t.references :creator_user, null: false, foreign_key: { to_table: :users }  # new reference for creator
      t.timestamps
    end
  end
end
