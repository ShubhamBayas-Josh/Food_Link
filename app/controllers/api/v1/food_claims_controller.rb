class Api::V1::FoodClaimsController < ApplicationController
  def index
    @food_claims = food_claim.all
    render json: @food_claims, status: :ok
  end

  def show
    if @food_claim
      render json: @food_claim, status: :ok
    else
      render json: { error: "food_claim not found" }, status: :not_found
    end
  end

  def create
    @food_claim = food_claim.new(food_claim_params)
    if @food_claim.save
      render json: @food_claim, status: :created
    else
      render json: { errors: @food_claim.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @food_claim.feedbacks.exists? || @food_claim.food_claims.exists? || @food_claim.food_transactions.exists? || @food_claim.notifications.exists?
      render json: { error: "Cannot delete food_claim with associated records" }, status: :unprocessable_entity
    else
      @food_claim.destroy
      render json: { message: "food_claim deleted successfully" }, status: :ok
    end
  end

  def update
    if @food_claim.update(food_claim_params)
      render json: @food_claim, status: :ok
    else
      render json: { error: @food_claim.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_food_claim
    @food_claim = food_claim.find_by(id: params[:id])
    if @food_claim.nil?
      render json: { error: "food_claim not found" }, status: :not_found
    end
  end

  def food_claim_params
    params.permit(:id, :name, :email, :password, :address, :organization_type)
  end
end
