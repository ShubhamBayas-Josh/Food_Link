class Api::V1::UsersController < ActionController::API
  before_action :set_user, only: [ :show, :update, :destroy ]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    if @user
      render json: @user, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    # Check if the user has associated records
    if @user.feedbacks.exists? || @user.food_claims.exists? || @user.food_transactions.exists? || @user.notifications.exists?
      render json: { error: "Cannot delete user with associated records" }, status: :unprocessable_entity
    else
      @user.destroy
      render json: { message: "User deleted successfully" }, status: :ok
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    if @user.nil?
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def user_params
    params.permit(:id, :name, :email, :password, :role, :address, :organization_type)
  end
end
