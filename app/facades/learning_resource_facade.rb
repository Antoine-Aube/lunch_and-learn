class LearningResourceFacade

  def self.get_learning_resource(country)
      video_response = VideoService.new.get_video(country)
      video_response_body = JSON.parse(video_response.body, symbolize_names: true)
      single_video = video_response_body[:items].sample || {}
      # require 'pry';binding.pry
      image_response = ImageService.new.get_images(country)
      image_response_body = JSON.parse(image_response.body, symbolize_names: true)
      image_results = image_response_body[:results]
      resource = LearningResource.new(single_video, image_results, country)
  end  
end