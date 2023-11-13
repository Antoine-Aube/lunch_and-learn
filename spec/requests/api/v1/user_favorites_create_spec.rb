require 'rails_helper'

RSpec.describe "Create a Favorite endpoint" do 
  describe "when I send a POST request to /api/v1/favorites" do
    it "returns a successful response and creates a user favorite in the database" do 
      user = User.create(name: "test", email: "test@test.com", password: "test")
      expect(Favorite.count).to eq(0)
      request = {
        "api_key": user.api_key,
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/crabfriedrce",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }
      post "/api/v1/favorites", params: request, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:success)
      expect(response_body[:success]).to eq("Favorite added successfully")
      expect(Favorite.count).to eq(1)
    end

    it "returns an error message if the api key is not found in the database" do 
      user = User.create(name: "test", email: "test@test.com", password: "test")
      request = {
        "api_key": "wrongapikey",
        "country": "thailand",
        "recipe_link": "https://www.tastingtable.com/crabfriedrce",
        "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }
      post "/api/v1/favorites", params: request, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:error)
      expect(response_body[:error]).to eq("Invalid API key")
    end
  end
end