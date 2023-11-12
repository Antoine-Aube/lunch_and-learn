class LearningResource
  attr_reader :id, :country, :video, :images

  def initialize(video_data, images_data, country)
    @id = nil 
    @country = country
    @video = video_data != {} ? format_video(video_data) : {}
    @images = format_images(images_data)
  end

  def format_video(video)
    {
      title: video[:snippet][:title],
      yoube_video_id: video[:id][:videoId]
    }
  end

  def format_images(images)
    images.map do |image|
      {
        alt_tag: image[:alt_description],
        url: image[:urls][:regular]
      }
    end
  end
end