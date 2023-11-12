require "rails_helper"

RSpec.describe CountryService do
  let(:service) { CountryService.new }

  describe "#sample_country", :vcr do
    it "returns a successful response with correct json" do
      response = service.sample_country
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body[0]).to be_a(Hash)
    end
  end
end