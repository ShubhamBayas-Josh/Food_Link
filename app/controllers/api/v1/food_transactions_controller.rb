class Api::V1::FoodTransactionsController < ApplicationController
  def index
    @food_transactions = food_transaction.all
    render json: @food_transactions, status: :ok
  end

  def show
    if @food_transaction
      render json: @food_transaction, status: :ok
    else
      render json: { error: "food_transaction not found" }, status: :not_found
    end
  end

  def create
    @food_transaction = food_transaction.new(food_transaction_params)
    if @food_transaction.save
      render json: @food_transaction, status: :created
    else
      render json: { errors: @food_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @food_transaction.feedbacks.exists? || @food_transaction.food_claims.exists? || @food_transaction.food_transactions.exists? || @food_transaction.notifications.exists?
      render json: { error: "Cannot delete food_transaction with associated records" }, status: :unprocessable_entity
    else
      @food_transaction.destroy
      render json: { message: "food_transaction deleted successfully" }, status: :ok
    end
  end

  def update
    if @food_transaction.update(food_transaction_params)
      render json: @food_transaction, status: :ok
    else
      render json: { error: @food_transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_food_transaction
    @food_transaction = food_transaction.find_by(id: params[:id])
    if @food_transaction.nil?
      render json: { error: "food_transaction not found" }, status: :not_found
    end
  end

  def food_transaction_params
    params.permit(:id, :name, :email, :password, :address, :organization_type)
  end
end
