class Api::V1::AdminsController < ApplicationController
  before_action :authorize_request
  def index
    @admins = Admin.all
    render json: @admins, status: :ok
  end

  def show
    if @admin
      render json: @admin, status: :ok
    else
      render json: { error: "admin not found" }, status: :not_found
    end
  end

  def create
    @admin = admin.new(admin_params)
    if @admin.save
      render json: @admin, status: :created
    else
      render json: { errors: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
      @admin.destroy
      render json: { message: "admin deleted successfully" }, status: :ok
  end


  def update
    if @admin.update(admin_params)
      render json: @admin, status: :ok
    else
      render json: { error: @admin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_admin
    @admin = admin.find_by(id: params[:id])
    if @admin.nil?
      render json: { error: "admin not found" }, status: :not_found
    end
  end

  def admin_params
    params.permit(:id, :name, :email, :password, :address, :organization_type)
  end
end
