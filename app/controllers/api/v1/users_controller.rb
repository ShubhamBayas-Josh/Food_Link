class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: [ :show, :update, :destroy, :approve ]
  # before_action :authorize_request
  before_action :authorize_request


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
    @user = User.new(user_params.merge(is_approved: false)) # default is_approved to false
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
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

  def approve
    if current_user.admin?  # only admin can approve users
      @user.update(is_approved: true)
      render json: { message: "User approved successfully" }, status: :ok
    else
      render json: { error: "You are not authorized to approve users" }, status: :forbidden
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
    params.permit(:id, :name, :email, :password, :address, :organization_type, :role)
  end
end
