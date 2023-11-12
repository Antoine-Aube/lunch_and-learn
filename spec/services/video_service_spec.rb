require 'rails_helper'

RSpec.describe VideoService do 
  let(:service) { VideoService.new }

  describe "#get_video" do 
    it "returns a successful response with correct json", :vcr do
      response = service.get_video("Vietnam")
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(response_body).to be_a(Hash)
    end
  end
end