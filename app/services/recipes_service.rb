class RecipesService
  
  def get_recipes(country)
    response = conn.get("/api/recipes/v2") do |req|
      req.params['q'] = country
    end
  end


  private
  
  def conn
    Faraday.new("https://api.edamam.com") do |f|
      f.headers['Content-Type'] = 'application/json'
      f.params['app_id'] = Rails.application.credentials.edamam[:app_id]
      f.params['app_key'] = Rails.application.credentials.edamam[:app_key]
      f.params['type'] = 'public'
    end
  end
end