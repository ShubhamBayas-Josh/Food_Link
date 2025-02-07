class Api::V1::AuthenticationController < Api::V1::ApplicationController
  skip_before_action :authenticate_request
  before_action :login_params, only: :login
  def login
    admin = Admin.find_by(email: login_params[:email])
    if admin&.valid_password?(login_params[:password])
      token = JsonWebToken.encode(admin_id: admin.id)
      # time = Time.now + 24.hours.to_i
      render json: { token: token }, status: :ok
    else
      render json: { error: "unauthorized user" }, status: :unauthorized
    end
  end


  private

  def login_params
    params.permit(:email, :password)
  end
end
