# spec/models/feedback_spec.rb
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:user) { create(:user) }
  let(:food_transaction) { create(:food_transaction, user: user) }

  subject {
    build(:feedback,
      user: user,
      food_transaction: food_transaction
    )
  }

  # Validation Tests
  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a rating" do
      subject.rating = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:rating]).to include("can't be blank")
    end

    it "is invalid without a comment" do
      subject.comment = nil
      expect(subject).not_to be_valid
      expect(subject.errors[:comment]).to include("can't be blank")
    end
  end

  # Association Tests
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:food_transaction) }
  end
end
