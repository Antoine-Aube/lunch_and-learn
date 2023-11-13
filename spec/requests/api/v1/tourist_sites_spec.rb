require "rails_helper"

RSpec.describe "Tourist Sites endpoint" do
  describe "GET /api/v1/tourist_sites" do
    it "returns a list of tourist sites for a given country with name, formatted address, and place ID" do
      get "/api/v1/tourist_sites?", params: {country: "Thailand"}  

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body, symbolize_names: true)

      parsed_response[:data].each do |tourist_site|
        expect(tourist_site).to have_key(:id)
        expect(tourist_site[:id]).to eq(nil)
        expect(tourist_site).to have_key(:type)
        expect(tourist_site[:type]).to be_a(String)
        expect(tourist_site[:type]).to eq("tourist_site")
        expect(tourist_site).to have_key(:attributes)
        
        site_attributes = tourist_site[:attributes]
        expect(site_attributes).to have_key(:name)
        expect(site_attributes[:name]).to be_a(String)
        expect(site_attributes).to have_key(:address)
        expect(site_attributes[:address]).to be_a(String)
        expect(site_attributes).to have_key(:place_id)
        expect(site_attributes[:place_id]).to be_a(String)
      end
    end
  end

  describe "sad path" do
    it " returns an empty array if nothing is found for the country search" do
      get "/api/v1/tourist_sites?", params: {country: "Antarctica"}

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end
  end
end