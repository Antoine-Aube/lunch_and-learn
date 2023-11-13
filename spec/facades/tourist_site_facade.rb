require 'rails_helper'

RSpec.describe TouristSitesFacade do
  let(:facade) { TouristSitesFacade }

  describe "#get_tourist_sites" do
    it "returns an array of TouristSite objects" do
      query = "Thailand"
      response = facade.get_tourist_sites(query)

      expect(response).to be_a(Array)
      expect(response[0]).to be_a(TouristSite)
    end
  end
end