# spec/models/food_claim_spec.rb
require "rails_helper"

RSpec.describe FoodClaim, type: :model do
  let(:user) { create(:user) }
  let(:creator_user) { create(:user) }
  let(:food_transaction) { create(:food_transaction, user: user) }
  let(:food_claim) { create(:food_claim, user: user, food_transaction: food_transaction, creator_user: creator_user) }

  describe "validations" do
    it { should validate_presence_of(:claimed_quantity) }
    it { should validate_presence_of(:claim_status) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:food_transaction) }
    it { should belong_to(:creator_user).class_name("User") }
  end

  describe "database columns" do
    it { should have_db_column(:claim_status).of_type(:string) }
  end
end
