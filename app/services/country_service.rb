class CountryService
  def sample_country
    conn.get("/v3.1/all")
  end

private

  def conn 
    Faraday.new("https://restcountries.com") do |f|
      f.headers['Content-Type'] = 'application/json'
    end
  end 
end