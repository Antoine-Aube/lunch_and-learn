class Api::V1::SessionsController < ApplicationController
  def create 
    request_body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: request_body[:email])
    if user &.authenticate(request_body[:password])
      render json: UserSerializer.new(user), status: 200
    else
      render json: {error: "Invalid email or password"}, status: 400
    end
  end
end