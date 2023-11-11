class RecipesFacade
  def self.get_recipes(country)
    response = RecipesService.new.get_recipes(country)
    response_body = JSON.parse(response.body, symbolize_names: true)
    response_body[:hits].map do |recipe_data|
      Recipe.new(recipe_data, country)
    end
  end
end