# spec/factories/food_claims.rb
FactoryBot.define do
  factory :food_claim do
    association :user
    association :food_transaction
    association :creator_user, factory: :user
    claimed_quantity { 1 }
    claim_status { "pending" }
  end
end
