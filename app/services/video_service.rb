class VideoService
  def get_video(country)
    response = conn.get("/youtube/v3/search") do |req|
      req.params['q'] = country
      req.params['type'] = "video"
      req.params['channelID'] = "UCDQ0pYBbR3rGWnn-BZJ9lXA"
    end
  end
  
  private
  
  def conn
    Faraday.new("https://www.googleapis.com") do |f|
      f.params['key'] = Rails.application.credentials.youtube[:api_key]
      f.params['part'] = "snippet"
    end
  end

end 

# "AIzaSyAa9m9c9auouEnv1qE-9Iab-mvUeP4kFrE"