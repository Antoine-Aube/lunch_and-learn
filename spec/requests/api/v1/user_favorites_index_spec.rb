require 'rails_helper'

RSpec.describe "User Favorites Index endpoint" do
  describe "GET /api/v1/favorites" do
    it "returns a successful response and a list of all user favorites" do
      user = User.create(name: "test", email: "test@test.com", password: "test")
      favorite = user.favorites.create(country: "thailand", recipe_link: "https://www.tastingtable.com/crabfriedrce", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")
      favorite2 = user.favorites.create(country: "America", recipe_link: "https://www.Burgers.com/burger", recipe_title: "Burger")

      get "/api/v1/favorites", params: {api_key: user.api_key}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response).to have_key(:data)
      expect(parsed_response[:data]).to be_an(Array)
      expect(parsed_response[:data].count).to eq(2)
      parsed_response[:data].each do |favorite|
        expect(favorite).to have_key(:id)
        expect(favorite[:id]).to be_a(String)
        expect(favorite).to have_key(:type)
        expect(favorite[:type]).to eq("favorite")
        expect(favorite).to have_key(:attributes)
        attributes = favorite[:attributes]
        expect(attributes).to have_key(:country)
        expect(attributes[:country]).to be_a(String)
        expect(attributes).to have_key(:recipe_link)
        expect(attributes[:recipe_link]).to be_a(String)
        expect(attributes).to have_key(:recipe_title)
        expect(attributes[:recipe_title]).to be_a(String)
      end
    end

    describe "sad path" do
      it "returns an error message if the api key is not found in the database" do
        user = User.create(name: "test", email: "test@test.com", password: "test")
        favorite = user.favorites.create(country: "thailand", recipe_link: "https://www.tastingtable.com/crabfriedrce", recipe_title: "Crab Fried Rice (Khaao Pad Bpu)")
        favorite2 = user.favorites.create(country: "America", recipe_link: "https://www.Burgers.com/burger", recipe_title: "Burger")

        get "/api/v1/favorites", params: {api_key: "wrongapikey"}

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response).to have_key(:error)
        expect(parsed_response[:error]).to eq("Invalid API key")
      end
    end
  end
end