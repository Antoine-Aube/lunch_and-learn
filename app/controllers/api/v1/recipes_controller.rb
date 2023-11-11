class Api::V1::RecipesController < ApplicationController
  def index
    country = params[:country]
    recipes = RecipesFacade.get_recipes(country)
    if !recipes.empty?
      render json: RecipeSerializer.new(recipes)
    else
      render json: {data: []}
    end
  end
end