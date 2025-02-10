# # require_relative "../json_web_token.rb"

class Api::V1::ApplicationController < ActionController::API
  def index
  render json: { message: "Hello from Api::V1::ApplicationController" }
  end
end
