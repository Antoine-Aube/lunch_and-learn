require "rails_helper"  

RSpec.describe CountryFacade do 
  let(:facade) { CountryFacade }

  describe "#sample_country", :vcr do
    it "returns an array of Country objects" do
      response = facade.sample_country

      expect(response).to be_a(Array)
      expect(response[0]).to be_a(Country)
    end 
  end
end