require "rails_helper"

RSpec. describe RecipesService do 
  let(:service) { RecipesService.new}

  describe "#get_recipes", :vcr do
    it "returns a successful response with correct json" do 
      query = "Vietnam"
      response = service.get_recipes(query)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to be_a(Hash)
    end
  end
end