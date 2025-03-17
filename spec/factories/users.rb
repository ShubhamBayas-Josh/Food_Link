  # spec/factories/users.rb
  FactoryBot.define do
    factory :user do
      # name { "Test User" }
      email { Faker::Internet.unique.email }  # Ensure unique email
      password { "password123" }
      password_confirmation { "password123" }
      name { Faker::Name.name } # If required

      role { "user" }
      address { "123 Test Street" }
    end
  end
