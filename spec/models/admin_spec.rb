# spec/models/admin_spec.rb
require 'rails_helper'

RSpec.describe Admin, type: :model do
  # Validation Tests
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  # Devise Modules
  describe "Devise modules" do
    let(:admin) { create(:admin) }

    it "responds to database_authenticatable" do
      expect(admin.valid_password?(admin.password)).to be true
    end

    it "responds to registerable" do
      expect(Admin.devise_modules).to include(:registerable)
    end

    it "responds to recoverable" do
      expect(Admin.devise_modules).to include(:recoverable)
    end

    it "responds to rememberable" do
      expect(Admin.devise_modules).to include(:rememberable)
    end

    it "responds to validatable" do
      expect(Admin.devise_modules).to include(:validatable)
    end

    it "responds to confirmable" do
      expect(Admin.devise_modules).to include(:confirmable)
    end
  end

  # Instance Methods
  describe "instance methods" do
    let(:admin) { create(:admin) }

    it "is valid with valid attributes" do
      expect(admin).to be_valid
    end

    it "is not valid without an email" do
      admin.email = nil
      expect(admin).to_not be_valid
    end
  end
end
