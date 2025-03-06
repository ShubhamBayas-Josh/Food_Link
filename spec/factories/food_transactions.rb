# spec/factories/food_transactions.rb
FactoryBot.define do
  factory :food_transaction do
    association :user
    food_type { "Vegetables" }
    quantity { 5 }
    description { "Fresh carrots available" }
    address { "123 Main Street, City" }
    transaction_type { "offer" }
    status { "pending" }
    expiration_date { 2.days.from_now }
  end
end
