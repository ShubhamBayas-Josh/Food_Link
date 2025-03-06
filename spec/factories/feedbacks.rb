# spec/factories/feedbacks.rb
FactoryBot.define do
  factory :feedback do
    association :user
    association :food_transaction
    rating { 5 }
    comment { "Great experience!" }
  end
end
