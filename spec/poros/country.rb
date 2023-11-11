require 'rails_helper'

RSpec.describe Country do 
  describe "intialize" do
    it "exists" do 
      country_data = {:name=>
        {:common=>"Turks and Caicos Islands",
        :official=>"Turks and Caicos Islands"
        }
      }

      country = Country.new(country_data)
      expect(country).to be_a(Country)
    end
  end
end