require 'rails_helper'

RSpec.describe LearningResourceFacade do
  let(:facade) { LearningResourceFacade }
  
  describe "#get_learning_resources" do
    it "returns a single Learning Resource object", :vcr do 
      country = "Vietnam"
      response = facade.get_learning_resource(country)

      expect(response).to be_a(LearningResource)
    end
  end
end