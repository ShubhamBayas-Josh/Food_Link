# spec/factories/admins.rb
FactoryBot.define do
  factory :admin do
    email { "shubhambayas7@gmail.com" }
    password { "1234567890" }
    confirmed_at { Time.current }
  end
end
