class PlacesService
  def get_tourist_sites(coordinates)
    conn.get("/v2/places") do |req|
      req.params[:categories] = 'tourism.sights'
      req.params[:filter] = "circle:#{coordinates[1]},#{coordinates[0]},10000"
    end
  end

  private

  def conn
    Faraday.new("https://api.geoapify.com") do |f|
      f.headers['Content-Type'] = 'application/json'
      f.params[:apiKey] = Rails.application.credentials.places[:api_key]
    end
  end
end