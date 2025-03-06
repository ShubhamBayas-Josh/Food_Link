require 'rails_helper'

RSpec.describe Api::V1::FoodClaimsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:creator_user) { create(:user) }
  let!(:food_transaction) { create(:food_transaction, user: creator_user) }
  let!(:food_claim) { create(:food_claim, user: user, food_transaction: food_transaction, creator_user_id: creator_user.id) }

  let(:valid_attributes) do
    {
      claimed_quantity: 2,
      claim_status: "pending",
      food_transaction_id: food_transaction.id,
      user_id: user.id,
      creator_user_id: creator_user.id
    }
  end

  let(:invalid_attributes) do
    {
      claimed_quantity: nil,
      claim_status: nil
    }
  end

  before do
    allow(controller).to receive(:authorize_request).and_return(true)
  end

  describe "GET #index" do
    it "returns all food claims" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(FoodClaim.count)
    end
  end

  describe "GET #show" do
  context "when the record exists" do
    it "returns the food claim" do
      get :show, params: { id: food_claim.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(food_claim.id)
    end
  end

  context "when the record does not exist" do
    it "returns a not found error" do
      get :show, params: { id: 9999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("food_claim not found")
    end
  end
end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new food claim" do
        expect {
          post :create, params: { food_claim: valid_attributes }
        }.to change(FoodClaim, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it "updates the food transaction status if update_transaction_status is true" do
        post :create, params: { food_claim: valid_attributes.merge(update_transaction_status: true) }
        food_transaction.reload
        expect(food_transaction.status).to eq("in_progress")
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity error" do
        post :create, params: { food_claim: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the food claim" do
        patch :update, params: { id: food_claim.id, food_claim: { claim_status: "approved" } }
        food_claim.reload
        expect(food_claim.claim_status).to eq("approved")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns an unprocessable entity error" do
        patch :update, params: { id: food_claim.id, food_claim: { claim_status: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the food claim" do
      expect {
        delete :destroy, params: { id: food_claim.id }
      }.to change(FoodClaim, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
