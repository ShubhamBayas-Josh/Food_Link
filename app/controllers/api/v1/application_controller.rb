# # require_relative "../json_web_token.rb"

class Api::V1::ApplicationController < ActionController::API
  def index
  render json: { message: "Hello from Api::V1::ApplicationController" }
  end

  def not_found
    render json: { error: "not_found" }, status: :not_found
  end

  def current_user
    @current_user
  end


  def authorize_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
