class Api::V1::FavoritesController < ApplicationController

  def index
    user = User.find_by(api_key: params[:api_key])
    if user
      favorites = user.favorites
      render json: FavoriteSerializer.new(favorites), status: 200
    else
      render json: {error: "Invalid API key"}, status: 404
    end
  end


  def create
    request_body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: request_body[:api_key])
    if user
      favorite = user.favorites.create(country: request_body[:country], recipe_link: request_body[:recipe_link], recipe_title: request_body[:recipe_title])
      render json: {success: "Favorite added successfully"}, status: 201
    else 
      render json: {error: "Invalid API key"}, status: 404
    end
  end
end