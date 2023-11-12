require 'rails_helper'

RSpec.describe "recipes endpoints" do 
  describe "GET /api/v1/recipes", :vcr do
    it "returns a successful response" do 
      get "/api/v1/recipes", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200) 
    end

    it "returns a list of recipes when provided a country parameter" do 
      get "/api/v1/recipes", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data]).to be_an(Array)
      expect(parsed_response[:data][0]).to be_a(Hash)

      single_recipe = parsed_response[:data][0]

      expect(single_recipe).to have_key(:id)
      expect(single_recipe[:id]).to eq(nil)
      expect(single_recipe).to have_key(:type)
      expect(single_recipe[:type]).to be_a(String)
      expect(single_recipe[:type]).to eq("recipe")
      expect(single_recipe).to have_key(:attributes)
      expect(single_recipe[:attributes]).to be_a(Hash)

      attributes = single_recipe[:attributes]

      expect(attributes).to have_key(:title)
      expect(attributes[:title]).to be_a(String)
      expect(attributes).to have_key(:url)
      expect(attributes[:url]).to be_a(String)
      expect(attributes).to have_key(:country)
      expect(attributes[:country]).to be_a(String)
      expect(attributes).to have_key(:image)
      expect(attributes[:image]).to be_a(String)
    end

    it "shouldn't have any unecessary data from the Edamam API" do 
      get "/api/v1/recipes", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data][0][:attributes].keys).to eq([:title, :url, :country, :image])
      expect(parsed_response[:data][0][:attributes].keys).to_not include(:uri, :yield, :dietLabels, :shareas, :cautions, :healthLabels)
    end

    it "returns and empty array  if nothing is found for the country search" do 
      get "/api/v1/recipes", params: {country: "asdfgasgasfg"}

      expect(response).to_not be_successful
      expect(response.status).to eq(404) 

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data]).to eq([])
    end
  end

  #might have to delete this one
  # describe "recipes endpoint with empty country parameter passed" do 
  #   it "return a recipe with all the recipe information", :vcr do
  #     get "/api/v1/recipes?country"
  #     expect(response).to be_successful
  #     expect(response.status).to eq(200)

  #     response_body = JSON.parse(response.body, symbolize_names: true)
  #     expect(response_body[:data]).to be_an(Array)
  #     # require 'pry';binding.pry
  #     expect(response_body[:data][0]).to be_a(Hash)

      
  #     single_recipe = response_body[:data][0]

  #     expect(single_recipe).to have_key(:id)
  #     expect(single_recipe[:id]).to eq(nil)
  #     expect(single_recipe).to have_key(:type)
  #     expect(single_recipe[:type]).to be_a(String)
  #     expect(single_recipe).to have_key(:attributes)
  #     expect(single_recipe[:attributes]).to be_a(Hash)

  #     attributes = single_recipe[:attributes]

  #     expect(attributes).to have_key(:title)
  #     expect(attributes[:title]).to be_a(String)
  #     expect(attributes).to have_key(:url)
  #     expect(attributes[:url]).to be_a(String)
  #     expect(attributes).to have_key(:country)
  #     expect(attributes[:country]).to be_a(String)
  #     expect(attributes).to have_key(:image)
  #     expect(attributes[:image]).to be_a(String)
  #   end 
  # end
end