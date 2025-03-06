require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  let!(:user) { create(:user, password: "password123") }
  let(:valid_login_params) { { email: user.email, password: "password123" } }
  let(:invalid_login_params) { { email: user.email, password: "wrongpassword" } }
  let(:signup_params) do
    {
      name: "New User",
      email: "newuser@example.com",
      password: "newpassword",
      address: "123 Main Street",
      role: "user",
      organization_type: "NGO"
    }
  end

  describe "POST #login" do
    context "with valid credentials" do
      it "returns a JWT token and user details" do
        post :login, params: valid_login_params
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["user"]["email"]).to eq(user.email)
        expect(json_response["user"]).to have_key("token")
      end
    end

    context "with invalid credentials" do
      it "returns unauthorized status" do
        post :login, params: invalid_login_params
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)["error"]).to eq("unauthorized")
      end
    end
  end

  describe "POST #signup" do
    context "with valid details" do
      it "creates a new user and returns a JWT token" do
        expect {
          post :signup, params: signup_params
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["user"]["email"]).to eq(signup_params[:email])
        expect(json_response).to have_key("token")
      end
    end

    context "with invalid details" do
      it "returns errors and does not create a user" do
        post :signup, params: signup_params.merge(email: "")
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end
end
