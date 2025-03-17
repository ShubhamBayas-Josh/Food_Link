class Api::V1::FeedbacksController < Api::V1::ApplicationController
  # skip_before_action :verify_authenticity_token, only: [ :create, :destroy, :update ]
  before_action :set_feedback, only: [ :show, :update, :destroy ]
  before_action :authorize_request


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
    @feedback.destroy
    render json: { message: "feedback deleted successfully" }, status: :ok
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
    params.permit(:id, :rating, :comment, :user_id, :food_transaction_id, :created_by_id)
  end
end
