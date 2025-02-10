<<<<<<< Updated upstream
class Api::V1::UsersController < Api::V1::ApplicationController # rubocop:disable Style/ColonMethodCall
  before_action :authenticate_request, only: [ :index, :show, :update, :destroy ]
=======
<<<<<<< Updated upstream
class Api::V1::UsersController < ActionController::API
=======
class Api::V1::UsersController < Api::V1::ApplicationController
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    render json: User.all, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted successfully" }, status: :ok
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: :not_found unless @user
  end

  def user_params
    params.permit(:name, :email, :password, :address, :organization_type)
  end
end
