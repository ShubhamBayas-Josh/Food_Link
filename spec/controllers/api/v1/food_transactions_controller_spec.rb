require 'rails_helper'

RSpec.describe Api::V1::FoodTransactionsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:food_transaction) { create(:food_transaction, user: user) }
  let(:valid_attributes) do
    attributes_for(:food_transaction, user_id: user.id)
  end
  let(:invalid_attributes) do
    { food_type: nil, quantity: nil }
  end

  before do
    allow(controller).to receive(:authorize_request).and_return(true)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(FoodTransaction.count)
    end
  end

  describe "GET #show" do
    context "when the record exists" do
      it "returns the food_transaction" do
        get :show, params: { id: food_transaction.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when the record does not exist" do
      it "returns a not found error" do
        get :show, params: { id: 9999 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("food_transaction not found")
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new FoodTransaction" do
        expect {
          post :create, params: valid_attributes
        }.to change(FoodTransaction, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity status" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the requested food_transaction" do
        patch :update, params: { id: food_transaction.id, food_type: "Updated Food" }
        food_transaction.reload
        expect(food_transaction.food_type).to eq("Updated Food")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        patch :update, params: { id: food_transaction.id, food_type: nil }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
  context "when food_transaction has no dependencies" do
    it "deletes the food_transaction" do
    end
  end
end
end
