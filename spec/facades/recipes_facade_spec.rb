require "rails_helper"

RSpec.describe RecipesFacade do
  let(:facade) { RecipesFacade }

  describe "#get_recipes" do 
    it "returns an array of Recipe ojects" do 
      query = "Vietnam"
      response = facade.get_recipes(query)

      
      expect(response).to be_a(Array)
      expect(response[0]).to be_a(Recipe)
    end
  end
end