require "rails_helper"

RSpec.describe Recipe do 
  describe "intialize" do 
    it "exists" do 
      recipe = Recipe.new({recipe: {label: "Duck Poutine", url: "www.website.com", image: "image.jpg"}}, "Thailand")
      expect(recipe).to be_a(Recipe)
      
      expect(recipe.title).to eq("Duck Poutine")
      expect(recipe.url).to eq("www.website.com")
      expect(recipe.country).to eq("Thailand")  
      expect(recipe.image).to eq("image.jpg")
    end
  end
end