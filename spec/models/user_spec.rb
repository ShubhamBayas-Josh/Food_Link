# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation Tests
  describe "validations" do
    subject { build(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:address) }
  end

  # Association Tests
  describe "associations" do
    it { should have_many(:feedbacks).dependent(:destroy) }
    it { should have_many(:food_claims).dependent(:destroy) }
    it { should have_many(:food_transactions).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
  end

  # Instance Methods
  describe "instance methods" do
    let(:user) { create(:user) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is not valid without a role" do
      user.role = nil
      expect(user).to_not be_valid
    end

    it "is not valid without an address" do
      user.address = nil
      expect(user).to_not be_valid
    end
  end

  # Secure Password Test
  describe "secure password" do
    let(:user) { create(:user) }

    it "authenticates with a valid password" do
      expect(user.authenticate(user.password)).to be_truthy
    end

    it "does not authenticate with an invalid password" do
      expect(user.authenticate("wrongpass")).to be_falsey
    end
  end
end
