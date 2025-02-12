class FeedbacksController < ApplicationController
  def index
    @feedback = Feedback.all
  end

  def show
    @feedback = Feedback.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Feedback not found"
    redirect_to users_path
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(user_params)
    if @feedback.save
      redirect_to @user, notice: "Feedback was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @feedback = Feedback.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "User not found"
    redirect_to users_path
  end

  def update
    if @feedback.update(user_params)
      redirect_to @feedback, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @feedback.destroy
      redirect_to users_path, notice: "User was successfully deleted."
    else
      redirect_to users_path, alert: "Error deleting user."
    end
  end

  private

  def set_user
    @user = Feedback.find(params[:id])
  end

  def user_params
    params.require(:feedback).permit(:email, :password, :name, :address)
  end
end
