require "rails_helper"

RSpec.describe TouristSite do 
  describe "initialize" do 
    it "exists" do 
      data = {:type=>"Feature",
              :properties=>{
                :name=>"พระบรมมหาราชวัง",
                :formatted=>"Grand Palace, Lak Mueang Road, Phra Nakhon District, Bangkok 10200, Thailand",
                :place_id=>"514962c43d791f594059cd959f26e17f2b40f00102f901825166010000000092032de0b89ee0b8a3e0b8b
                            0e0b89ae0b8a3e0b8a1e0b8a1e0b8abe0b8b2e0b8a3e0b8b2e0b88ae0b8a7e0b8b1e0b887"
                          }
            }     

      tourist_site = TouristSite.new(data)
      expect(tourist_site).to be_a(TouristSite)
    end
  end
end