class Api::V1::FoodClaimsController < Api::V1::ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_food_claim, only: [ :show, :update, :destroy ]
  before_action :authorize_request

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
      # If the update_transaction_status flag is true, update the related food transaction
      if params[:food_claim][:update_transaction_status]
        food_transaction = FoodTransaction.find(@food_claim.food_transaction_id)
        food_transaction.update(status: "in_progress")
      end

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
    params.require(:food_claim).permit(:claimed_quantity, :claim_status, :food_transaction_id, :user_id, :creator_user_id)
  end
end
