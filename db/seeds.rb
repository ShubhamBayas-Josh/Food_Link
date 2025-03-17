# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

users = [
  { name: "Shubham", email: "shubhambayas7@gmail.com", password: "Shubham@123", role: "Donor", address: "Damani nagar", organization_type: "Hotel" },
  { name: "Harsh", email: "harsh8@gmail.com", password: "Harsh@123", role: "Donor", address: "pune", organization_type: "Hotel" },
  { name: "Abhay", email: "abhays123@gmail.com", password: "Abhay@123", role: "Ngo", address: "pune", organization_type: "community" },
  { name: "Yash", email: "yash8@gmail.com", password: "Yash@123", role: "Donor", address: "Solapur", organization_type: "Restuarant" },
  { name: "Shreyash", email: "shreyash1@gmail.com", password: "Shreyash@123", role: "Ngo", address: "Mumbai", organization_type: "community" }
]

user_records = {}

users.each do |user_data|
  user = User.find_or_create_by!(email: user_data[:email]) do |u|
    u.name = user_data[:name]
    u.password = user_data[:password]
    u.role = user_data[:role]
    u.address = user_data[:address]
    u.organization_type = user_data[:organization_type]
  end
  user_records[user.email] = user
end

food_transactions = [
  { user_email: "shubhambayas7@gmail.com", food_type: "Rice", quantity: 10, description: "Freshly cooked rice", address: "Damani Nagar", transaction_type: "offer", status: "pending", expiration_date: DateTime.now + 2.days },
  { user_email: "harsh8@gmail.com", food_type: "Bread", quantity: 20, description: "Packaged bread", address: "Pune", transaction_type: "offer", status: "pending", expiration_date: DateTime.now + 3.days },
  { user_email: "abhays123@gmail.com", food_type: "Vegetables", quantity: 15, description: "Fresh vegetables", address: "Pune", transaction_type: "request", status: "pending", expiration_date: DateTime.now + 1.day },
  { user_email: "yash8@gmail.com", food_type: "Milk", quantity: 5, description: "1L packets", address: "Solapur", transaction_type: "offer", status: "pending", expiration_date: DateTime.now + 4.days },
  { user_email: "shreyash1@gmail.com", food_type: "Fruits", quantity: 12, description: "Bananas and apples", address: "Mumbai", transaction_type: "request", status: "pending", expiration_date: DateTime.now + 2.days }
]

food_transactions.each do |transaction_data|
  user = User.find_by(email: transaction_data[:user_email])
  next unless user # Skip if user not found

  FoodTransaction.create!(
    user: user,
    food_type: transaction_data[:food_type],
    quantity: transaction_data[:quantity],
    description: transaction_data[:description],
    address: transaction_data[:address],
    transaction_type: transaction_data[:transaction_type],
    status: transaction_data[:status],
    expiration_date: transaction_data[:expiration_date]
  )
end

food_claims = [
  { user_email: "abhays123@gmail.com", food_transaction_id: 1, claimed_quantity: 5, claim_status: "pending", creator_email: "yash8@gmail.com" },
  { user_email: "yash8@gmail.com", food_transaction_id: 2, claimed_quantity: 10, claim_status: "pending", creator_email: "shreyash1@gmail.com" }
]

food_claims.each do |claim_data|
  user = User.find_by(email: claim_data[:user_email])
  creator = User.find_by(email: claim_data[:creator_email])
  food_transaction = FoodTransaction.find_by(id: claim_data[:food_transaction_id])
  next unless user && creator && food_transaction

  FoodClaim.create!(
    user: user,
    food_transaction: food_transaction,
    claimed_quantity: claim_data[:claimed_quantity],
    claim_status: claim_data[:claim_status],
    creator_user: creator
  )
end

feedbacks = [
  { user_email: "shubhambayas7@gmail.com", food_transaction_id: 1, rating: 5, comment: "Great quality!", created_by_email: "abhays123@gmail.com" },
  { user_email: "harsh8@gmail.com", food_transaction_id: 2, rating: 4, comment: "Good but needs better packaging", created_by_email: "yash8@gmail.com" }
]

feedbacks.each do |feedback_data|
  user = User.find_by(email: feedback_data[:user_email])
  created_by = User.find_by(email: feedback_data[:created_by_email])
  food_transaction = FoodTransaction.find_by(id: feedback_data[:food_transaction_id])
  next unless user && created_by && food_transaction

  Feedback.create!(
    user: user,
    food_transaction: food_transaction,
    rating: feedback_data[:rating],
    comment: feedback_data[:comment],
    created_by_id: created_by.id  # Updated this line to use created_by_id
  )
end

puts "Seed data successfully added!"
