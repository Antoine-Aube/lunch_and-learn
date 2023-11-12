require 'rails_helper'

RSpec.describe ImageService do
  let(:service) { ImageService.new }

  describe "get_images" do
    it "returns a successful response with correct json", :vcr do
      response = service.get_images("Vietnam")
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to be_a(Hash)
    end
  end
end