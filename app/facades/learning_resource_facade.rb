class LearningResourceFacade

  def self.get_learning_resource(country)
      single_video = get_video(country)
      image_results = get_image(country)
      resource = LearningResource.new(single_video, image_results, country)
  end  

  def self.get_video(country)
    video_response = VideoService.new.get_video(country)
    parse_json(video_response)[:items].sample || {}
  end

  def self.get_image(country)
    image_response = ImageService.new.get_images(country)
    parse_json(image_response)[:results]
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end