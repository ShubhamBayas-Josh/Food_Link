require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_attributes) do
    { name: 'Test User', email: 'test@example.com', password: 'password123', role: 'user' }
  end

  let(:admin) { create(:user, role: 'admin') }
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new user' do
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user has dependencies' do
      it 'does not allow deletion' do
      end
    end
  end

  describe 'PATCH #approve' do
    # before { sign_in admin }

    context 'when admin approves a user' do
      it 'sets is_approved to true' do
        # expect(response).to have_http_status(:ok)
      end
    end

    context 'when a non-admin tries to approve' do
      it 'returns an authorization error' do
      end
    end
  end
end
