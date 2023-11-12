class ImageService
  def get_images(country)
    response = conn.get("/search/photos") do |req|
      req.params['query'] = country
    end
  end

private

  def conn
    Faraday.new("https://api.unsplash.com") do |f|
      f.params['client_id'] = Rails.application.credentials.unsplash[:api_key]
    end
  end
end