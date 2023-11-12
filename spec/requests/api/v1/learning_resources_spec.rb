require "rails_helper"

RSpec.describe "learning_resources endpoints" do
  describe "get /api/v1/learning_resources" do
    it "returns a successful response" do
      get "/api/v1/learning_resources", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it "returns a learning resource with videos and photos when providedq a country parameter" do
      get "/api/v1/learning_resources", params: {country: "Vietnam"}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:data]).to be_a(Hash)
      expect(parsed_response[:data]).to have_key(:id)
      expect(parsed_response[:data][:id]).to eq(nil)
      expect(parsed_response[:data]).to have_key(:type)
      expect(parsed_response[:data][:type]).to eq("learning_resource")

      expect(parsed_response[:data]).to have_key(:attributes)
      expect(parsed_response[:data][:attributes]).to be_a(Hash)
      video = parsed_response[:data][:attributes][:video]
      expect(video).to be_an(Hash)
      expect(video).to have_key(:title)
      expect(video[:title]).to be_a(String)
      expect(video).to have_key(:yoube_video_id)
      expect(video[:yoube_video_id]).to be_a(String)

      images = parsed_response[:data][:attributes][:images]

      expect(images).to be_an(Array)
      images.each do |image|
        expect(image).to be_a(Hash)
        expect(image).to have_key(:alt_tag)
        expect(image[:alt_tag]).to be_a(String)
        expect(image).to have_key(:url)
        expect(image[:url]).to be_a(String)
      end 
    end

    it "return empty video and image attributes if nothing is found for the country search" do
      get "/api/v1/learning_resources", params: {country: "asdfasdfasfgsadfgadsgeadsgerwtvsdb"}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body[:data][:attributes][:video]).to eq({})
      expect(response_body[:data][:attributes][:images]).to eq([])
    end
  end
end