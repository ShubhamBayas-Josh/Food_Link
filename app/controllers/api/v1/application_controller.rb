# require_relative "../json_web_token.rb"

class Api::V1::ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_request

  private
  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = JsonWebToken.decode(header)
    @current_admin = Admin.find(decoded[:admin_id])
  end
end
