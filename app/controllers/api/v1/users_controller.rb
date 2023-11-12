class Api::V1::UsersController < ApplicationController
  # before_action :request_body, only: [:create]
  
  def create
    request_body = JSON.parse(request.body.read, symbolize_names: true)
      user = User.create(name: request_body[:name], 
      email: request_body[:email], 
      password: request_body[:password],
      password_confirmation: request_body[:password_confirmation])
    user_create_response(user)
  end

  def user_create_response(user)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else
      render json: {error: user.errors.full_messages.to_sentence}, status: 400
    end
  end
end