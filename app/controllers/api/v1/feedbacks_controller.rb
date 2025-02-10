class Api::V1::FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all
    render json: @feedbacks, status: :ok
  end

  def show
    if @feedback
      render json: @feedback, status: :ok
    else
      render json: { error: "feedback not found" }, status: :not_found
    end
  end

  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: { errors: @feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @feedback.feedbacks.exists? || @feedback.food_claims.exists? || @feedback.food_transactions.exists? || @feedback.notifications.exists?
      render json: { error: "Cannot delete feedback with associated records" }, status: :unprocessable_entity
    else
      @feedback.destroy
      render json: { message: "feedback deleted successfully" }, status: :ok
    end
  end

  def update
    if @feedback.update(feedback_params)
      render json: @feedback, status: :ok
    else
      render json: { error: @feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_feedback
    @feedback = Feedback.find_by(id: params[:id])
    if @feedback.nil?
      render json: { error: "feedback not found" }, status: :not_found
    end
  end

  def feedback_params
    params.permit(:id, :name, :email, :password, :address, :organization_type)
  end
end
