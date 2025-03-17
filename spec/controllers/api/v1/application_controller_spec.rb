require "rails_helper"

RSpec.describe Api::V1::ApplicationController, type: :controller do
  controller(Api::V1::ApplicationController) do
    def index
      render json: { message: "Hello from Api::V1::ApplicationController" }
    end

    def not_found
      super
    end

    def test_authorize_request
      return if performed? # Prevents double rendering

      authorize_request
      if @current_user.present?
        render json: { user_id: @current_user.id }
      else
        # render json: { errors: "Unauthorized access" }, status: :unauthorized
      end
    end
  end

  let(:user) { create(:user) }
  let(:valid_token) { JsonWebToken.encode(user_id: user.id) }
  let(:invalid_token) { "invalid.token.string" }

  before do
    routes.draw do
      get "index" => "api/v1/application#index"
      get "not_found" => "api/v1/application#not_found"
      get "test_authorize_request" => "api/v1/application#test_authorize_request"
    end
  end

  describe "GET #index" do
    it "returns a success message" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ "message" => "Hello from Api::V1::ApplicationController" })
    end
  end

  describe "GET #not_found" do
    it "returns a not_found error" do
      get :not_found
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ "error" => "not_found" })
    end
  end

  describe "Authorization" do
    context "with a valid token" do
      before do
        request.headers["Authorization"] = "Bearer #{valid_token}"
      end

      it "authorizes the user and returns user_id" do
        get :test_authorize_request
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq({ "user_id" => user.id })
      end
    end

    context "with an invalid token" do
      before do
        request.headers["Authorization"] = "Bearer #{invalid_token}"
      end

      it "returns unauthorized error" do
        get :test_authorize_request
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include("errors")
      end
    end

    context "without a token" do
      it "returns unauthorized error" do
        get :test_authorize_request
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include("errors")
      end
    end
  end
end
