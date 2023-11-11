require 'rails_helper'

RSpec.describe "recipes endpoints" do 
  describe "GET /api/v1/recipes" do
    it "returns a successful response" do 
      get "/api/v1/recipes", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true) 
      require 'pry';binding.pry
    end
  end
end