class Recipe
  attr_reader :title, :url, :country, :image

  def initialize(recipe_data, country)
    @title = recipe_data[:recipe][:label]
    @url = recipe_data[:recipe][:url]
    @country = country
    @image = recipe_data[:recipe][:image]
  end
end