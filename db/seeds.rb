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

for user_data in users do
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.name = user_data[:name]
    user.password = user_data[:password]
    user.role = user_data[:role]
    user.address = user_data[:address]
    user.organization_type = user_data[:organization_type]
  end
end

# For Food Transaction Request
food_transactions = [
  { email: "shubhambayas7@gmail.com", food_type: "Rice", quantity: 100, description: "Staple food", address: "Damani nagar", transaction_type: "Donation", status: "Pending", expiration_date: Date.new(2025, 3, 1) },
  { email: "harsh8@gmail.com", food_type: "Vegetables", quantity: 50, description: "Fresh vegetables", address: "pune", transaction_type: "Donation", status: "Completed", expiration_date: Date.new(2025, 2, 15) },
  { email: "abhays123@gmail.com", food_type: "Rice", quantity: 200, description: "Staple food for community", address: "pune", transaction_type: "Request", status: "Pending", expiration_date: Date.new(2025, 3, 10) },
  { email: "yash8@gmail.com", food_type: "Bread", quantity: 150, description: "Freshly baked bread", address: "Solapur", transaction_type: "Donation", status: "Completed", expiration_date: Date.new(2025, 2, 25) },
  { email: "shreyash1@gmail.com", food_type: "Fruits", quantity: 120, description: "Seasonal fruits", address: "Mumbai", transaction_type: "Request", status: "Pending", expiration_date: Date.new(2025, 3, 5) }
]

food_transactions.each do |transaction_data|
  user = User.find_by(email: transaction_data[:email])

  if user
    FoodTransaction.find_or_create_by!(user_id: user.id, food_type: transaction_data[:food_type], quantity: transaction_data[:quantity], description: transaction_data[:description]) do |transaction|
      transaction.address = transaction_data[:address]
      transaction.transaction_type = transaction_data[:transaction_type]
      transaction.status = transaction_data[:status]
      transaction.expiration_date = transaction_data[:expiration_date]
    end
  end
end
# User.delete_all
