require 'rails_helper'

RSpec.describe PlacesService do 
  let(:service) { PlacesService.new }

  describe "#get_tourist_sites" do
    it "returns a successful response with correct json" do
      coordinates = TouristSitesFacade.get_capital_coordinates("Thailand")
      response = service.get_tourist_sites(coordinates)
      response_body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(200)
      expect(response_body).to be_a(Hash)
      expect(response_body[:features]).to be_a(Array) 
    end
  end
end