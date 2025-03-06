class Api::V1::AuthenticationController < Api::V1::ApplicationController
  # controller actions
  before_action :authorize_request, except: [ :login, :signup ]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: {
        user: {
          email: @user.email,
          token: token,
          role: @user.role
        }
      }, status: :ok
    else
      render json: { error: "unauthorized" }, status: :unauthorized
    end
  end


  # POST /auth/signup
  def signup
    @user = User.new(user_params.merge(is_approved: false)) # Default is_approved to false

    if @user.save
      token = JsonWebToken.encode(user_id: @user.id) # Generate JWT token
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: { id: @user.id, name: @user.name, email: @user.email } }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def login_params
    params.permit(:email, :password)
  end

  private
  private

  def user_params
    params[:organization_type] = params.delete(:organizationType) if params[:organizationType]

    params.permit(:name, :email, :password, :address, :role, :organization_type)
  end
end
