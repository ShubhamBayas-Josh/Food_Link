require 'rails_helper'

RSpec.describe "Admins", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:admin) { Admin.create!(email: "shubhambayas7@gmail.com", password: "1234567890", confirmed_at: Time.current) }

  before do
    sign_in admin
  end

  describe "GET /admins" do
    it "returns a success response" do
      get admins_path
      expect(response).to have_http_status(:ok)
    end

    it "redirects if admin is not signed in" do
      sign_out admin
      get admins_path
      expect(response).to redirect_to(new_admin_session_path)
      follow_redirect!
      expect(response.body).to include("You need to sign in or sign up before continuing.")
    end
  end

  describe "GET /admins/:id" do
    it "returns a success response for an existing admin" do
      get admin_path(admin)
      expect(response).to have_http_status(:ok)
    end

    it "redirects when admin is not found" do
      get admin_path(id: 999)
      expect(response).to redirect_to(admins_path)
      follow_redirect!
      expect(response.body).to include("Admin not found.")
    end
  end

  describe "GET /admins/new" do
    it "renders the new admin page" do
      get new_admin_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /admins" do
    it "creates a new admin with valid parameters" do
    end

    it "does not create a new admin with invalid parameters" do
      expect {
        post admins_path, params: { admin: { email: "", password: "" } }
      }.not_to change(Admin, :count)
    end
  end

  describe "PATCH /admins/:id" do
    it "updates the admin with valid parameters" do
      patch admin_path(admin), params: { admin: { email: "updated@example.com" } }
      admin.reload
      # expect(admin.email).to eq("updated@example.com")
    end

    it "does not update the admin with invalid parameters" do
      patch admin_path(admin), params: { admin: { email: "" } }
      admin.reload
      expect(admin.email).not_to eq("")
    end
  end

  describe "DELETE /admins/:id" do
    it "destroys the admin" do
      expect {
        delete admin_path(admin)
      }.to change(Admin, :count).by(-1)
    end

    it "redirects to the admins list" do
      delete admin_path(admin)
      expect(response).to redirect_to(admins_path)
    end
  end
end
