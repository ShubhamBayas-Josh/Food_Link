require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      admin = Admin.new(email: "sample@gmail.com", password: "password", name: "sample")
      admin.save!
      expect(admin.name.present?).to eq(true), "Admin should have a name"
    end

    it 'ensures name absence' do
      admin = Admin.new(email: "sample@gmail.com", password: "password", name: nil)
      expect(admin.save).to eq(false), "Admin should not be saved without a name"
    end

    it 'ensures email presence' do
      admin = Admin.new(email: "sample@gmail.com", password: "password", name: "sample")
      admin.save!
      expect(admin.email.present?).to eq(true), "Admin should have an email"
    end

    it 'ensures email absence' do
      admin = Admin.new(email: nil, password: "password", name: "sample")
      expect(admin.save).to eq(false), "Admin should not be saved without an email"
    end

    it 'ensures email format is valid' do
      admin = Admin.new(email: "invalid_email", password: "password", name: "sample")
      expect(admin.save).to eq(false), "Admin should not be saved with an invalid email"
    end

    it 'ensures email format is invalid' do
      admin = Admin.new(email: "sample@gmail.com", password: "password", name: "sample")
      expect(admin.save).to eq(true), "Admin should be saved with a valid email"
    end

  end
end
