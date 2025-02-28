class Api::V1::FoodClaimsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_food_claim, only: [ :show, :update, :destroy ]

  def index
    @food_claims = FoodClaim.all
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
    @food_claim = FoodClaim.new(food_claim_params)
    if @food_claim.save
      render json: @food_claim, status: :created
    else
      render json: { errors: @food_claim.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @food_claim.destroy
    render json: { message: "food_claim deleted successfully" }, status: :ok
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
    @food_claim = FoodClaim.find_by(id: params[:id])
    if @food_claim.nil?
      render json: { error: "food_claim not found" }, status: :not_found
    end
  end

  def food_claim_params
    params.permit(:id, :claimed_quantity, :claim_status, :food_transaction_id, :user_id, :creator_user_id)
  end
end
