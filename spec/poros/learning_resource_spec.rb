require 'rails_helper'

RSpec.describe LearningResource do
  describe "intialize" do 
    it "exists" do
      country = "Vietnam"
      video_data = {:kind=>"youtube#searchResult",
      :etag=>"CDnkzkrhIjEXbQatVbi1b3Qj0CU",
      :id=>{:kind=>"youtube#video", :videoId=>"hd73bwOvsoI"},
      :snippet=>
       {:publishedAt=>"2023-10-28T14:07:03Z",
        :channelId=>"UCCg-8XaLD8SGrXGwv7TWphQ"
      }
      }
      images_data = [{:id=>"vcu-OZBxxRk",
      :alt_description=>
       "high-angle photography of boats on water near hill during daytime",
      :urls=>
       {:regular=>
         "https://images.unsplash.com/photo-1528127269322-53980
          1943592?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w1Mj
          cwODR8MHwxfHNlYXJjaHwxfHxWaWV0bmFtfGVufDB8fHx8MTY5OTc1NDc0O
          Xww&ixlib=rb-4.0.3&q=80&w=1080"
        }
      }]
      

      
        learning_resource = LearningResource.new(video_data, images_data, country)
        expect(learning_resource).to be_a(LearningResource)
    end
  end
end