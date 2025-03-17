# spec/models/food_transaction_spec.rb
require 'rails_helper'

RSpec.describe FoodTransaction, type: :model do
  subject { build(:food_transaction) }

  # Validation Tests
  describe "validations" do
    it "is invalid without a food_type" do
      subject.food_type = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:food_type]).to include("can't be blank")
    end

    it "is invalid without a quantity" do
      subject.quantity = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:quantity]).to include("can't be blank")
    end

    it "is invalid without a description" do
      subject.description = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:description]).to include("can't be blank")
    end

    it "is invalid without an address" do
      subject.address = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:address]).to include("can't be blank")
    end

    it "is invalid without a transaction_type" do
      subject.transaction_type = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:transaction_type]).to include("can't be blank")
    end

    it "is invalid with an invalid transaction_type" do
      subject.transaction_type = "invalid_type"
      expect(subject).not_to be_valid
      expect(subject.errors[:transaction_type]).to include("invalid_type is not a valid transaction type")
    end

    it "is invalid without a status" do
      subject.status = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:status]).to include("can't be blank")
    end

    it "is invalid with an invalid status" do
      subject.status = "unknown_status"
      expect(subject).not_to be_valid
      expect(subject.errors[:status]).to include("unknown_status is not a valid status")
    end

    it "is invalid without an expiration_date" do
      subject.expiration_date = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:expiration_date]).to include("can't be blank")
    end
  end

  # Association Tests
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:feedbacks) }
    it { should have_many(:food_claims) }
  end
end
