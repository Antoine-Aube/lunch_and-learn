class Api::V1::RecipesController < ApplicationController
  before_action :country, only: [:index]

  def index
    recipes = RecipesFacade.get_recipes(@country)
    if !recipes.empty?
      render json: RecipeSerializer.new(recipes)
    else
      render json: {data: []}, status: 404
    end
  end

private

  def country
    @country = params[:country] || CountryFacade.sample_country.sample.name
  end 
end